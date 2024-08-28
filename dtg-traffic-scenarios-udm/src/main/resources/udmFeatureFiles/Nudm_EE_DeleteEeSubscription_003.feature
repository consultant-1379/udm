Feature: Unsubscribe UE reachability
#This scenario should be executed after Nudm_EE_CreateEeSubscription_003.feature

#FT:
# Subscribe
#for i in {00000..00100}; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"callbackReference": "http://testinjector/callback/uri/CallbackReferenceUri", "monitoringConfiguration": {"3": {"referenceId": 3, "eventType": "UE_REACHABILITY_FOR_SMS"}}}' 'http://localhost:31382/nudm-ee/v1/'$MSISDN'/ee-subscriptions';done

#Unsubscribe
#curl --http2-prior-knowledge -k -i -m 1 -X DELETE 'http://localhost:31382/nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions/id-subscription-3'

Scenario: Send DeleteEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions/<SavedSubscriptionId>
  Given request header is Content-Type:application/json
  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
