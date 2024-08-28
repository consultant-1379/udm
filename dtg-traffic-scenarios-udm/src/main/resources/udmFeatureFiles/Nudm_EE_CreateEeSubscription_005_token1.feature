Feature: EE subscription (Event Type = Location Request) with extid

Scenario: Default callback handler initialization
  Given callback request to server number 6 type AMF_HTTP
  Given callback request HTTP method POST
  Given callback request path prefix /namf-evts/v1/subscriptions
  Given action name is Amf6CreateEventSubscription
  When we receive callback request
  Then we send default response with status code 201 and headers [content-type:application/json; location:subscriptions/<imsi>@ericsson.com] and content
 """
  {
    "subscription": {"eventList": [{"type": "LOCATION_REPORT", "locationFilterList": ["TAI"]}],
    "options": {"trigger": "CONTINUOUS"},
    "eventNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v2/amfnotif",
    "notifyCorrelationId": "imsi-<imsi>",
    "nfId": "841d1b7c-5103-11e9-8c09-174c95907e28",
    "subsChangeNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v1/amfsubsidchangenotif/imsi-<imsi>",
    "supi": "imsi-<imsi>"},
    "subscriptionId":"http://udm.ericsson.se:8080/amf06/<imsi>@ericsson.com"
  }
  """

Scenario: Send CreateEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/extid-<imsi>@ericsson.com/ee-subscriptions
  Given request header is Authorization:Bearer <token_ee>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "callbackReference": "http://udm.ericsson.se:8080/amf06/callback/uri/callbackUri",
    "monitoringConfigurations": {"123456789": {"eventType":"LOCATION_REPORTING",
                                               "locationReportingConfiguration":{"currentLocation":true,
                                                                                 "oneTime":false,
                                                                                 "accuracy":"TA_LEVEL"}
                                                }
                                  },
    "reportingOptions" : {"reportMode":"PERIODIC",
                          "maxNumOfReports":5,
                          "expiry":"2030-11-30T23:59:59Z",
                          "reportPeriod":100},
    "notifyCorrelationId" : "imsi-<imsi>"
   }
  """
  When we send POST request
  Then we expect response status code 201
  Then compute SavedSubscriptionId using Subscriber-Id-From-Response-Location-Header algorithm
  Then we expect response time less than 2000 milliseconds
