Feature:  SMSF registration data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsfInstanceId": "b20af4ca-72f5-4d53-8af4-f088bf28a901", "plmnId": {"mcc": "111", "mnc": "222"}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/imsi-00010/context-data/smsf-3gpp-access'

Scenario: Send TC-UDRSIM-0090
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/smsf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"smsfInstanceId": "b20af4ca-72f5-4d53-8af4-f088bf28a901","plmnId": {"mcc": "111", "mnc": "222"}}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
