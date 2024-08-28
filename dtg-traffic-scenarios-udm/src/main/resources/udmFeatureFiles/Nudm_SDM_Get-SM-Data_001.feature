Feature: Get SM Data

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"dnnConfigurations": {"ims": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "MAY_PREEMPT", "preemptVuln":"NOT_PREEMPTABLE"}, "priorityLevel": 127}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET"], "defaultSessionType":"IPV4"}, "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes":["SSC_MODE_1"],"defaultSscMode": "SSC_MODE_3"}, "ladnIndicator": true, "iwkEpsInd": true,  "3gppChargingCharacteristics":"0001", "upSecurity": {"upIntegr": "NOT_NEEDED", "upConfid": "NOT_NEEDED"}}, "*": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE"}, "priorityLevel":1}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET","IPV4V6"], "defaultSessionType": "IPV6"}, "sessionAmbr":{"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes": ["SSC_MODE_2"],"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": true, "iwkEpsInd": true, "3gppChargingCharacteristics": "0000", "upSecurity": {"upIntegr": "PREFERRED", "upConfid": "PREFERRED"}}, "ericsson-network": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE"}, "priorityLevel": 127}, "pduSessionTypes": {"allowedSessionTypes": ["ETHERNET","IPV4V6"], "defaultSessionType": "IPV6"}, "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "sscModes": {"allowedSscModes":["SSC_MODE_2"],"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": true, "iwkEpsInd": true, "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}], "upSecurity": {"upIntegr": "NOT_NEEDED", "upConfid": "NOT_NEEDED"}}}, "singleNssai": {"sd": "000002", "sst": 2}},   {"dnnConfigurations": {"Internet": {"5gQosProfile": {"5qi": 5, "arp": {"priorityLevel": 1, "preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE"}},  "pduSessionTypes": {"defaultSessionType": "IPV4"}, "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"}, "sscModes":  {"defaultSscMode": "SSC_MODE_1"}, "ladnIndicator": false, "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}]}}, "singleNssai": {"sd": "000001", "sst": 2}}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/sm-data';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:30080/nudm-sdm/v2/imsi-240810000000000/sm-data'

#No other Scenarios execution dependencies

Scenario: Send Get-SM-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/sm-data
  Given request header is Content-Type:application/json
  Given action name is GET-sm-data
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
