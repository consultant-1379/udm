Feature:  Authentication vector data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "5G_AKA", "eKi": "IrOqNNQMCQ1tTDt3Y4VK+w==", "amfValue": 47545, "fsetInd": 0,"seqHe": "AAAAAAAA", "ind5gAusf": 25, "a4KeyInd": 1,  "a4Ind": 2, "indCscf": 0}' 'http://127.0.0.1:30082/nudr-dr/v1/subscription-data/imsi-00070/authentication-data'


Scenario: Send TC-UDRSIM-0070_002
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/authentication-data
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"authenticationMethod": "5G_AKA",
   "eKi": "IrOqNNQMCQ1tTDt3Y4VK+w==",
   "amfValue": 47545,
   "fsetInd": 0,
   "seqHe": "AAAAAAAA",
   "ind5gAusf": 25,
   "a4KeyInd": 1,
   "a4Ind": 2,
   "indCscf": 0}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
