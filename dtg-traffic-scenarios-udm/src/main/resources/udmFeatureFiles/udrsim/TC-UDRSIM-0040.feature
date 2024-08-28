Feature:  AMF registration data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": true, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00040/context-data/amf-3gpp-access'


Scenario: Send TC-UDRSIM-0040
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
