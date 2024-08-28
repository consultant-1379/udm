Feature: Get SMF Select Data

#Provisioning script
#for i in {00000..00099};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscribedSnssaiInfos": {"2-000002":{"dnnInfos": [{"defaultDnnIndicator": true, "dnn": "ericsson-network", "lboRoamingAllowed": true, "iwkEpsInd": true}]}}}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/smf-selection-subscription-data';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:30080/nudm-sdm/v2/imsi-240810000000000/smf-select-data'

#No other Scenarios execution dependencies

Scenario: Send Get-SMF-Select-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/smf-select-data
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/json
  Given action name is GET-smf-data
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
