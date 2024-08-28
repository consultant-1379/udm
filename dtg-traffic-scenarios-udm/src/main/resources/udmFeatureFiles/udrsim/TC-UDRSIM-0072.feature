Feature:  AMF REGISTRATION not ROAMING

Scenario: Send TC-UDRSIM-0072
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/msisdn-<msisdn>/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d146275555",
   "deregCallbackUri": "http://amf05.ericsson.net/callback/uri/deregCallbackUri",
   "registrationTime": "2019-03-22T09:14:00Z",
   "purgeFlag": false,
   "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B555"},
   "ratType": "NR"}
   """

   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds


