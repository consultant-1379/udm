Feature: Modify a Subscription to notification of SMF data change

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"monitoredResourceUris": ["http://udm.ericsson.com/nudm-sdm/v2/imsi-<imsi>/smf-select-data"],"expires": "2050-12-31T23:20:50Z"}' 'http://localhost:30080/nudm-sdm/v2/imsi-240820000240000/sdm-subscriptions'

#No other scenarios execution dependencies

Scenario: Send Susbcribe-SDM-Datachange
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/sdm-subscriptions/<SavedSubscriptionId2>
  Given action name is PATCH-subscription-smf
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/merge-patch+json
  Given request content is
  """
  {
    "monitoredResourceUris" : ["<UDM_CLIENT_SCHEME>://<UDM_CLIENT_DESTINATION_HOST>:<UDM_CLIENT_DESTINATION_PORT>/nudm-sdm/v2/imsi-<imsi>/smf-select-data"],
    "expires": "2050-12-31T23:20:50Z"
  }
  """
  When we send PATCH request
  Then we expect response status code 200
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
