Feature: Subscribe UE reachability

#Provisioning script:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"callbackReference": "", "monitoringConfiguration": {}}' 'http://localhost:30082/nudr-dr/v1/subscription-data/anyUE/group-data/ee-subscriptions'

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"callbackReference": "http://testinjector/callback/uri/CallbackReferenceUri", "monitoringConfigurations": {"3": {"eventType": "UE_REACHABILITY_FOR_SMS"}}}' 'http://localhost:31382/nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions'

#No other Scenarios dependencies

Scenario: Send CreateEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "callbackReference": "<GENERIC_SERVER_SCHEME>://<GENERIC_SERVER_ADDRESS>:<GENERIC_SERVER_PORT>/UeReachabilityReport/imsi-<imsi>/",
    "monitoringConfigurations": {"3":{"eventType":"UE_REACHABILITY_FOR_SMS"}}
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then compute SavedSubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response time less than 2000 milliseconds
