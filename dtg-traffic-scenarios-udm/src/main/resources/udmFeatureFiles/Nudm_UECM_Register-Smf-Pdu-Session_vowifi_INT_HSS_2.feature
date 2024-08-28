Feature: SMF Registration Vowifi

#Provisioning scripts:

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"smfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "dnn": "ericsson-network", "pduSessionId": 0,"plmnId": {"mcc": "111", "mnc": "222"},"singleNssai": {"sd":"000002", "sst": 2 },"pgwFqdn":"test_pgwFqdn","epdgInd": false}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smf-registrations';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"dnnConfigurations": {"ims": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "MAY_PREEMPT", "preemptVuln":"NOT_PREEMPTABLE"}, "priorityLevel": 127}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET"], "defaultSessionType":"IPV4"}, "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes":["SSC_MODE_1"],"defaultSscMode": "SSC_MODE_3"}, "ladnIndicator": true, "iwkEpsInd": true,  "3gppChargingCharacteristics":"0001", "upSecurity": {"upIntegr": "NOT_NEEDED", "upConfid": "NOT_NEEDED"}}, "*": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE"}, "priorityLevel":1}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET","IPV4V6"], "defaultSessionType": "IPV6"}, "sessionAmbr":{"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes": ["SSC_MODE_2"],"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": true, "iwkEpsInd": true, "3gppChargingCharacteristics": "0000", "upSecurity": {"upIntegr": "PREFERRED", "upConfid": "PREFERRED"}}, "ericsson-network": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE"}, "priorityLevel": 127}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET","IPV4V6"], "defaultSessionType": "IPV6"}, "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes":["SSC_MODE_2"],"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": true, "iwkEpsInd": true, "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}], "upSecurity": {"upIntegr": "NOT_NEEDED", "upConfid": "NOT_NEEDED"}}}, "singleNssai": {"sd": "000002", "sst": 2}},   {"dnnConfigurations": {"Internet": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE"}},  "pduSessionTypes": {"defaultSessionType": "IPV4"}, "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"}, "sscModes":  {"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": false, "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}]}}, "singleNssai": {"sd": "000001", "sst": 2}}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/sm-data';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"smfInstanceId": "e09ea573-2ac3-4c22-8def-e2a992ae6da4", "dnn": "ericsson-network", "pduSessionId": 1,"plmnId": {"mcc": "111", "mnc": "222"}, "singleNssai": {"sd": "000002", "sst": 2},"pgwFqdn":"test_pgwFqdn","epdgInd": false}' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000000/registrations/smf-registrations/1'

Scenario: Send Register-Smf Vowifi
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/smf-registrations/1
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "smfInstanceId":"1ae99999-b046-11e8-96f8-529269fb0002",
    "dnn":"ericsson-roaming",
    "pduSessionId":1,
    "plmnId": {"mcc": "360", "mnc": "02"} ,
    "singleNssai": {"sd": "000002", "sst": 2},
    "pgwFqdn":"other_pgwFqdn",
    "epdgInd": true
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
