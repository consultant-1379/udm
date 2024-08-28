Feature:  SMF registration data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"smfInstanceId": "e09ea573-2ac3-4c22-8def-e2a992ae6da4", "dnn": "ericsson-network", "pduSessionId": 0,"plmnId": {"mcc": "111", "mnc": "222"},"singleNssai": {"sd":"000002", "sst": 2 }}]' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00060/context-data/smf-registrations'


Scenario: Send TC-UDRSIM-0060
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/smf-registrations
   Given request header is Content-Type:application/json
   Given request content is

   """
   [{"smfInstanceId": "e09ea573-2ac3-4c22-8def-e2a992ae6da4",
   "dnn": "ericsson-network",
   "pduSessionId": 0,
   "plmnId": {"mcc": "111", "mnc": "222"},
   "singleNssai": {"sd":"000002", "sst": 2 }},
   {"smfInstanceId": "e09ea573-2ac3-4c22-8def-eeeeeeeeeee9",
   "dnn": "world-network",
   "pduSessionId": 0,
   "plmnId": {"mcc": "555", "mnc": "666"},
   "singleNssai": {"sd":"000002", "sst": 2 }}]
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
