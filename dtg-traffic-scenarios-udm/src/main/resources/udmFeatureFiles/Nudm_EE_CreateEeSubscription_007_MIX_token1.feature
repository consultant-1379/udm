Feature: EE subscription (Event Type =  Loss of Connectivity)

Scenario: Default callback handler initialization
  Given callback request to server number 9 type AMF_HTTP
  Given callback request HTTP method POST
  Given callback request path prefix /namf-evts/v1/subscriptions
  Given action name is Amf9CreateEventSubscription
  Given callback request content property named subscription.supi has key
  Given callback request content before key imsi-
  Then we wait for callback request

Scenario: Send CreateEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions
  Given request header is Authorization:Bearer <token_ee>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "callbackReference": "http://udm.ericsson.se:8080/amf11/callback/uri/callbackUri",
    "monitoringConfigurations": {"123456789": {"eventType":"LOSS_OF_CONNECTIVITY"},
                                 "123456787": {"eventType":"LOCATION_REPORTING",
                                               "locationReportingConfiguration":{"currentLocation":true,
                                                                                 "oneTime":false,
                                                                                 "accuracy":"TA_LEVEL"}
                                                },
                                  "123456788": {"eventType":"UE_REACHABILITY_FOR_DATA"}
                                  },
    "reportingOptions" : {"reportMode":"ON_EVENT_DETECTION",
                          "maxNumOfReports":5,
                          "expiry":"2030-11-30T23:59:59Z"},
    "notifyCorrelationId" : "imsi-<imsi>"
   }
  """
  When we send POST request
  Then we expect callback request
  Then we save incoming callback request content property named subscription.subsChangeNotifyCorrelationId as parameter subsChangeNotifyCorrelationId
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
  Then we expect response status code 201
  Then compute SavedSubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response time less than 2000 milliseconds
