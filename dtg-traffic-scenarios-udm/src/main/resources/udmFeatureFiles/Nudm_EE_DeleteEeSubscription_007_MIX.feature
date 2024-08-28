Feature: Feature: EE subscription (Mixed Event Types =  Loss of Connectivity, Location Reporting, UE Reachability for data)

Scenario: Default callback handler initialization
  Given callback request to server number 9 type AMF_HTTP
  Given callback request HTTP method DELETE
  Given callback request path prefix /namf-evts/v1/subscriptions/
  Given action name is Amf9DeleteEventSubscription
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send DeleteEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions/<SavedSubscriptionId>
  Given request header is Content-Type:application/json
  When we send DELETE request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
