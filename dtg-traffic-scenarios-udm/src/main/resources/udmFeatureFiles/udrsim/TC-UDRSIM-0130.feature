Feature: sms-waiting population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"scAddressList": []}' 'http://localhost:30098/nudr-dr/v1/subscription-data/imsi-240810000000000/context-data/sms-waiting'

Scenario: Send TC-UDRSIM-0130
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/sms-waiting
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"scAddressList": []}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
