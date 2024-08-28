Feature: Subscribe smf-registrations Data

#Provisioning script

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d '{"nfInstanceId" : "1ec823fe-4a62-4617-aabf-55d14627a3dd","callbackReference": "http://AMF_SERVER_HOST:AMF_SERVER_PORT/callback/uri/CallbackReferenceUri", "monitoredResourceUris": ["http://udm.ericsson.com/nudm-sdm/v2/imsi-<imsi>/ue-context-in-smf-data"], "plmnId": {"mcc": "111", "mnc": "222"}}' 'http://localhost:30080/nudm-sdm/v2/imsi-240810000000000/sdm-subscriptions'

#No other Scenarios execution dependencies

Scenario: Send Susbcribe-smf-registrations-Datachange
  Given target type is UDM_HTTP
  Given target tag is HTTP_2_PLAIN
  Given path is /nudm-sdm/v2/imsi-<imsi>/sdm-subscriptions
  Given action name is POST-subscription-smf-registrations
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "nfInstanceId" : "455aa5a7-f43e-40b0-aa70-4ed1caf65e6c",
    "callbackReference" : "http://214.1.158.12:8094/sdmDataChange/imsi-<imsi>/",
    "monitoredResourceUris" : ["<UDM_CLIENT_SCHEME>://<UDM_CLIENT_DESTINATION_HOST>:<UDM_CLIENT_DESTINATION_PORT>/nudm-sdm/v2/imsi-<imsi>/ue-context-in-smf-data"],
    "plmnId": {"mcc": "111", "mnc": "222"}
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then compute SavedSubscriptionId8 using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
