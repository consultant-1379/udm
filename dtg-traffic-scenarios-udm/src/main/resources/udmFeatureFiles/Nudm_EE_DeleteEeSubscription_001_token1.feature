Feature: EE Unsubscription (Event Type = Subscribe Roaming Status change)

Scenario: Send DeleteEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions/<SavedSubscriptionId>
  Given request header is Authorization:Bearer <token_ee>
  Given request header is Content-Type:application/json
  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
