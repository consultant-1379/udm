Feature: EE subscription (Event Type = SUPI-PEI Change (Any UE))

Scenario: Send CreateEeSubscription SUPI PEI Change AnyUE
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/anyUE/ee-subscriptions
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "callbackReference": "<GENERIC_SERVER_SCHEME(5)>://<GENERIC_SERVER_ADDRESS(5)>:<GENERIC_SERVER_PORT(5)>/nef01/callback/uri/callbackUri",
    "monitoringConfigurations": {"1":{"eventType":"CHANGE_OF_SUPI_PEI_ASSOCIATION"}}
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then compute SavedSubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response time less than 2000 milliseconds
