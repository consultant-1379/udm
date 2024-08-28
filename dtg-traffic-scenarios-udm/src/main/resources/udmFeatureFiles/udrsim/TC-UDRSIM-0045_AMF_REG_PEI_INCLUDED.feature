Feature:  AMF registration data population with PEI

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri","imsVoPs": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},  "ratType": "NR"}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00040/context-data/amf-3gpp-access'

Scenario: Send TC-UDRSIM-0045_AMF_REG_PEI_INCLUDED
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
   "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri",
   "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
   "ratType": "NR",
   "pei": "imei-999990000<pei>0"
   }
   """

   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
