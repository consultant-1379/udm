Feature: Subscribe SMS Data with ImplicitUnsubscribe

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"nfInstanceId" : "b20af4ca-72f5-4d53-8af4-f088bf28a901","callbackReference": "http://AMF_SERVER_HOST:AMF_SERVER_PORT/callback/uri/CallbackReferenceUri", "monitoredResourceUris": ["http://udm.ericsson.com/nudm-sdm/v2/imsi-<imsi>/sms-data"]}' 'http://localhost:30080/nudm-sdm/v2/imsi-240810000000000/sdm-subscriptions'

#No other scenarios execution dependencies
#The nfInstanceId used here it is the SMSF one. 

Scenario: Send Susbcribe-SDM-Datachange
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/sdm-subscriptions
  Given action name is POST-subscription-sms
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "nfInstanceId" : "2ec823fe-4a62-4617-aabf-55d14627a3dd",
    "callbackReference" : "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:8089/callback/uri/CallbackReferenceUri",
    "monitoredResourceUris" : ["<UDM_CLIENT_SCHEME>://<UDM_CLIENT_DESTINATION_HOST>:<UDM_CLIENT_DESTINATION_PORT>/nudm-sdm/v2/imsi-<imsi>/sms-data"],
    "implicitUnsubscribe" : true
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then we expect response status code 204
  Then compute SavedSubscriptionId3 using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response time less than 2000 milliseconds
