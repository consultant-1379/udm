Feature: EE unsubscribe (Event Type = SUPI-PEI Change (Any UE))

Scenario: Send DeleteEeSubscription SUPI PEI Change AnyUE
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/anyUE/ee-subscriptions/<SavedSubscriptionId>
  Given request header is Authorization:Bearer <token_ee>
  Given request header is Content-Type:application/json
  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
