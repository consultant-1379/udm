Feature:  AMF REGISTRATION not ROAMING

Scenario: Send TC-UDRSIM-0047
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v2/subscription-data/extid-<imsi>@ericsson.com/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d146276666",
   "deregCallbackUri": "http://amf06.ericsson.net/callback/uri/deregCallbackUri",
   "registrationTime": "2019-03-22T09:14:00Z",
   "purgeFlag": false,
   "guami": {"plmnId": {"mcc": "333", "mnc": "44"}, "amfId": "A1B666"},
   "ratType": "NR"}
   """

   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds


