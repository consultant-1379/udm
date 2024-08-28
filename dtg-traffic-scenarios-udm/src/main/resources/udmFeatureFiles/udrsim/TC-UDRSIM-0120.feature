Feature:  SUPI and GPSI data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "imsi-00012", "gpsi": "msisdn-00012"}' 'http://localhost:30098/nudr-dr/v1/subscription-data/msisdn-00012/id-translation-result'

Scenario: Send TC-UDRSIM-0120
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/msisdn-<msisdn>/id-translation-result
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"supi": "imsi-<imsi>",
   "gpsi": "msisdn-<msisdn>"}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
