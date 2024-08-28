Feature: Get AM Data and SMF Select Data

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "", "deregCallbackUri": "", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": true, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri":"http://amf01.ericsson.net/callback/uri/deregCallbackUri","guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"}}' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000100/registrations/amf-3gpp-access'

#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:30082/nudm-sdm/v2/imsi-240810000000000?dataset-names=AM,SMF_SEL'

#No other scenarios execution dependencies

Scenario: Send Get-AM-Data and SMF-Select-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>?dataset-names=AM,SMF_SEL
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/json
  Given action name is GET-multiple-data-set
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
