Feature: Get AM Data

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:30080/nudm-sdm/v2/imsi-240810000000000/am-data?plmn-id=%7b%22mcc%22%3a+%22111%22%2c+%22mnc%22%3a+%22222%22%7d'

#No other scenarios execution dependencies

Scenario: Send Get-AM-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/am-data?plmn-id=%7b%22mcc%22%3a+%22111%22%2c+%22mnc%22%3a+%22222%22%7d
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/json
  Given action name is GET-am-data
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
