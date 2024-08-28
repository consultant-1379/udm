Feature: Get UE-CONTEXT-IN-SMF-Data

#Provisioning script

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"smfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "dnn": "ericsson-network", "pduSessionId": 0,"plmnId": {"mcc": "111", "mnc": "222"},"singleNssai": {"sd":"000002", "sst": 2 }}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smf-registrations';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://10.210.49.96:31382/nudm-sdm/v2/imsi-240810000000002/ue-context-in-smf-data'
#No other Scenarios execution dependencies

Scenario: Send Get-UE-CONTEXT-IN-SMF-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/ue-context-in-smf-data
  Given request header is Content-Type:application/json
  Given action name is GET-ue-context-data
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
