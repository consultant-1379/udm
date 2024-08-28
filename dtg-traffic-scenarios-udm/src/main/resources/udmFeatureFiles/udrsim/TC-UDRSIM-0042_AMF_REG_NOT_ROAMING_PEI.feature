Feature:  AMF REGISTRATION not ROAMING

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri","pei": "","lastAMFRegistrationTS": "","purgeFlag": false, "imsVoPs": "NON_HOMOGENEOUS_OR_UNKNOWN","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}, "ratType": "NR"}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00012/context-data/amf-3gpp-access'

Scenario: Send TC-UDRSIM-0042
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
   "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri",
   "pei": "imei-999990000<pei>0",
   "registrationTime": "2019-03-22T09:14:00Z",
   "purgeFlag": false,
   "imsVoPs": "NON_HOMOGENEOUS_OR_UNKNOWN",
   "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
   "ratType": "NR"}
   """

   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
