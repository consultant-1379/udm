Feature:  SMS subscription data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"moSmsSubscribed": true, "mtSmsSubscribed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00110/111222/provisioned-data/sms-mng-data'


Scenario: Send TC-UDRSIM-00110
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/sms-mng-data
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"moSmsSubscribed": true,
   "mtSmsSubscribed": false}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
