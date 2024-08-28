Feature: Unsubscribe SMF Data

#This scenario should be run after Nudm_SDM_Subscribe-SDM-Datachange_002.feature

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X DELETE -H'content-type:application/json' 'http://localhost:30610/nudm-sdm/v2/imsi-240810000000000/sdm-subscriptions/testinjector-callback-uri-CallbackReferenceUri-smf-select-data'

Scenario: Send Unsusbcribe-SMF-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/sdm-subscriptions/<SavedSubscriptionId2>
  Given action name is DELETE-subscription-smf
  Given request header is Content-Type:application/json
  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds




