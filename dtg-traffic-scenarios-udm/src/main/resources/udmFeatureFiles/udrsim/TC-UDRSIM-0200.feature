Feature:  supiList and gpsiList provisioning

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "imsi-00012", "gpsi": "msisdn-00012"}' 'http://localhost:30098/nudr-dr/v2/subscription-data/imsi-00012/identity-data'

Scenario: Send TC-UDRSIM-0120
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v2/subscription-data/imsi-<imsi>/identity-data
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"supiList": ["imsi-<imsi>"],
   "gpsiList": ["msisdn-<msisdn>"]}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
