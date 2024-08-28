Feature:  Authentication vector data population including a4keyversion

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "EAP_AKA_PRIME","encPermanentKey": "22B3AA34D40C090D6D4C3B7763854AFB","authenticationManagementField": "B9B9","algorithmId": "0", "protectionParameterId": "1$2","sequenceNumber":{"indLength": 5,"sqnScheme": "NON_TIME_BASED","sqn": "000000000000","difSign": "NEGATIVE","lastIndexes":{ "ausf": 25}}}' 'http://127.0.0.1:30082/nudr-dr/v2/subscription-data/imsi-240820000000001/authentication-data/authentication-subscription'

Scenario: Send TC-UDRSIM-0072_001_TUAK
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v2/subscription-data/imsi-<imsi>/authentication-data/authentication-subscription
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"authenticationMethod": "EAP_AKA_PRIME",
    "encPermanentKey": "22B3AA34D40C090D6D4C3B7763854AFB",
    "authenticationManagementField": "B9B9",
    "algorithmId": "5",
    "protectionParameterId": "1$2$a4KeyV:1",
    "sequenceNumber":
     {"indLength": 5,
      "sqnScheme": "NON_TIME_BASED",
      "sqn": "000000000000",
      "difSign": "NEGATIVE",
      "lastIndexes":
    	{ "ausf": 25}
      }
   }
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
