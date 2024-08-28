Feature:  Authentication vector data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authType": "EAP_AKA_PRIME", "nfInstanceId": "instanceId", "success": true, "timeStamp": "2000-01-01 12:00:00"}' 'http://127.0.0.1:30082/nudr-dr/v1/subscription-data/imsi-00071/auth-event'


Scenario: Send TC-UDRSIM-0071_001
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/auth-event
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"authType": "EAP_AKA_PRIME",
   "nfInstanceId": "instanceId",
   "success": true,
   "timeStamp": "2000-01-01 12:00:00"}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
