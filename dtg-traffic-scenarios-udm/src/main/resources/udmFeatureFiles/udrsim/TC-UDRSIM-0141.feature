Feature:  SMS data subscription data population (management)

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsManagementSubscriptionData": {"mtSmsSubscribed": true,"mtSmsBarringAll":false,"mtSmsBarringRoaming": false,"moSmsSubscribed": true,"moSmsBarringAll":false,"moSmsBarringRoaming": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00051/provisioned-data/sms-mng-data'


Scenario: Send TC-UDRSIM-0141
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/sms-mng-data
   Given request header is Content-Type:application/json
   Given request content is

   """
   {
   "mtSmsSubscribed": true, 
   "mtSmsBarringAll":false, 
   "mtSmsBarringRoaming": false,
   "moSmsSubscribed": true, 
   "moSmsBarringAll":false, 
   "moSmsBarringRoaming": false}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
