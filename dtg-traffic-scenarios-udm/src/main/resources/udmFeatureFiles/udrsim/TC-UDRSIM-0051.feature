Feature:  Notification of data change subscription data population (empty data populated)

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUris": []}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00051/sub-data-subscriptions'


Scenario: Send TC-UDRSIM-0051
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/sub-data-subscriptions
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"subscriptionId": "",
   "callbackReference": "",
   "monitoredResourceUris": []}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
