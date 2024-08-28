Feature: IMSRegistration_Deregistration_Rel16

#This scenario will be run after Nudm_UECM_Register-Smf-Pdu-Session_002.feature

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"dnnConfigurations": {"ims": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "MAY_PREEMPT", "preemptVuln":"NOT_PREEMPTABLE"}, "priorityLevel": 127}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET"], "defaultSessionType":"IPV4"}, "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes":["SSC_MODE_1"],"defaultSscMode": "SSC_MODE_3"}, "ladnIndicator": true, "iwkEpsInd": true,  "3gppChargingCharacteristics":"0001", "upSecurity": {"upIntegr": "NOT_NEEDED", "upConfid": "NOT_NEEDED"}}, "*": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE"}, "priorityLevel":1}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET","IPV4V6"], "defaultSessionType": "IPV6"}, "sessionAmbr":{"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes": ["SSC_MODE_2"],"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": true, "iwkEpsInd": true, "3gppChargingCharacteristics": "0000", "upSecurity": {"upIntegr": "PREFERRED", "upConfid": "PREFERRED"}}, "ericsson-network": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE"}, "priorityLevel": 127}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET","IPV4V6"], "defaultSessionType": "IPV6"}, "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes":["SSC_MODE_2"],"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": true, "iwkEpsInd": true, "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}], "upSecurity": {"upIntegr": "NOT_NEEDED", "upConfid": "NOT_NEEDED"}}}, "singleNssai": {"sd": "000002", "sst": 2}},   {"dnnConfigurations": {"Internet": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE"}},  "pduSessionTypes": {"defaultSessionType": "IPV4"}, "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"}, "sscModes":  {"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": false, "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}]}}, "singleNssai": {"sd": "000001", "sst": 2}}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/sm-data';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"smfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "dnn": "ericsson-network", "pduSessionId": 0,"plmnId": {"mcc": "111", "mnc": "222"},"singleNssai": {"sd":"000002", "sst": 2 }}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smf-registrations';done

#FT:
#curl -k -i -m 1 -X POST -H'content-type:application/json' -d '{"deregReason": "PCSCF_RESTORATION"}' 'http://localhost:30096/nudm-voice-uecm/v1/imsi-240810000000000/ims-registration/deregistration'

Scenario: Default callback handler initialization
  Given action name is pcscfrestoration-callback-smf1-rel16
  Given callback request to server number 1 type SMF_HTTP
  Given callback request path prefix /pcscfrestoration
  Given callback request with before key imsi-
  Given callback request with after key /
  Then we wait for callback request


Scenario: Send IMSRegistration_Deregistration
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/restore-pcscf
  Given request header is Content-Type:application/json
  Given request content is
    """

{
  "supi": "imsi-<imsi>"
}

    """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
  Given callback handler action name is pcscfrestoration-callback-smf1-rel16
  Then we expect callback request
  Then we send callback response with status code 204
