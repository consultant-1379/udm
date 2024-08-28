Feature: Subscribe SM Data

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"nfInstanceId" : "e09ea573-2ac3-4c22-8def-e2a992ae6da4","callbackReference": "http://AMF_SERVER_HOST:AMF_SERVER_PORT/sdmDataChange/imsi-240810000000000/", "monitoredResourceUris": ["http://udm.ericsson.com/nudm-sdm/v2/imsi-<imsi>/sm-data"]}' 'http://localhost:30080/nudm-sdm/v2/imsi-240810000000000/sdm-subscriptions'

#No other scenarios execution dependencies

Scenario: Send Susbcribe-SDM-Datachange
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/sdm-subscriptions
  Given action name is POST-subscription-sm
  Given request header is Content-Type:application/json
  Given request header is Authorization:Bearer <udmAccesstoken>
  Given request content is
    """
{
  "nfInstanceId" : "e09ea573-2ac3-4c22-8def-e2a992ae6da4",
  "callbackReference" : "<SMF_SERVER_SCHEME>://<SMF_SERVER_ADDRESS>:<SMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/",
  "monitoredResourceUris" :["<UDM_CLIENT_SCHEME>://<UDM_CLIENT_DESTINATION_HOST>:<UDM_CLIENT_DESTINATION_PORT>/nudm-sdm/v2/imsi-<imsi>/sm-data"]
}

    """
  When we send POST request
  Then we expect response status code 201
  Then compute SavedSubscriptionId3 using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response status code 204
  Then we expect response time less than 1100 milliseconds

