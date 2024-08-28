Feature: EE subscription (Delete AnyUE ee Subcription)


Scenario: Send TC-UDRSIM-CreateEeSuscription
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v2/subscription-data/group-data/anyUE/ee-subscriptions/<SavedSubscriptionId>
   Given request header is Content-Type:application/json
   When we send DELETE request
   Then we expect response status code 204
   Then we expect response time less than 2000 milliseconds

