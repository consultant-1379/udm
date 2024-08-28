Feature: EE subscription (Event Type = Subscribe Roaming Status change)

Scenario: Send CreateEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions
  Given request header is Authorization:Bearer <token_ee>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "callbackReference": "<GENERIC_SERVER_SCHEME(5)>://<GENERIC_SERVER_ADDRESS(5)>:<GENERIC_SERVER_PORT(5)>/nef01/callback/uri/callbackUri",
    "monitoringConfigurations": {"<RANDOM_VALUE>":{"eventType":"ROAMING_STATUS","immediateFlag":true}},
    "reportingOptions" : {"reportMode":"ON_EVENT_DETECTION",
                          "maxNumOfReports":200,
                          "expiry":"2030-12-30T23:59:59Z"}
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then compute SavedSubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response time less than 2000 milliseconds
