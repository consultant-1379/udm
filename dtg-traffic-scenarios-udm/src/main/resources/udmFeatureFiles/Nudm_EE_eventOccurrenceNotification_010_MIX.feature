Feature: EE subscription (Event Type =  Loss of Connectivity, Location Reporting and UE Reachability for Data)

Scenario: Default callback handler initialization
  Given callback request to server number 9 type AMF_HTTP
  Given callback request HTTP method PUT
  Given callback request path prefix /namf-evts/v1/subscriptions
  Given action name is Amf9BISCreateEventSubscription
  Given callback request content property named subscription.supi has key
  Given callback request content before key imsi-
  Then we wait for callback request

Scenario: Send Initial Register-Amf3GPPAccess
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d146281111",
    "deregCallbackUri": "http://amf11.ericsson.net/callback/uri/deregCallbackUri",
    "ratType" : "NR",
    "noEeSubscriptionInd": true,
    "purgeFlag": false,
    "isInHomePlmn": true
  }
  """
  When we send PUT request
  Then we expect callback request
  Then we send callback response with status code 201 and headers [content-type:application/json; location:subscriptions/<msisdn>] and content
 """
  {
    "subscription": {"eventList": [{"type": "LOSS_OF_CONNECTIVITY"}, {"type": "LOCATION_REPORT"}, {"type": "REACHABILITY_REPORT"}],
    "options": {"trigger": "CONTINUOUS"},
    "eventNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v2/amfnotif",
    "notifyCorrelationId": "imsi-<imsi>",
    "nfId": "841d1b7c-5103-11e9-8c09-174c95907e28",
    "subsChangeNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v1/amfsubsidchangenotif/imsi-<imsi>",
    "supi": "imsi-<imsi>"},
    "subscriptionId":"http://udm.ericsson.se:8080/amf11/<msisdn>"
  }
  """
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
