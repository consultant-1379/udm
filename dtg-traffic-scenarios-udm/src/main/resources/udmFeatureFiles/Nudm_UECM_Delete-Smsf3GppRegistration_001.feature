Feature: Delete-Smsf3GppRegistration

#This scenario should be executed after Nudm_UECM_Register-Smsf3GppAccess_001.feature

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsfInstanceId": "", "plmnId": {"mcc": "", "mnc": ""}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smsf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data';done


#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X DELETE 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000100/registrations/smsf-3gpp-access'

Scenario: Send Delete-Smsf3GppRegistration
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/smsf-3gpp-access
  Given request header is Content-Type:application/json
  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
