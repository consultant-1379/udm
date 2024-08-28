Feature: EE subscription (Event Type =  UE Reachability for SMS)

Scenario: Default callback handler initialization
  Given action name is CreateEventSubscription_Callback_AMF_NEF1
  Given callback request to server number 5 type GENERIC_HTTP
  Given callback request HTTP method POST
  Given callback request path prefix /namf-evts/v1/subscriptions
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
    "callbackReference": "<GENERIC_SERVER_SCHEME(6)>://<GENERIC_SERVER_ADDRESS(6)>:<GENERIC_SERVER_PORT(6)>/nef01/callback/uri/callbackUri",
    "monitoringConfigurations": {"<RANDOM_VALUE>": {"eventType":"UE_REACHABILITY_FOR_SMS","reachabilityForSmsCfg":"REACHABILITY_FOR_SMS_OVER_NAS"}
                                  },
    "reportingOptions" : {"reportMode":"ON_EVENT_DETECTION",
                          "maxNumOfReports":1,
                          "expiry":"2030-11-30T23:59:59Z"}
   }
  """
  When we send POST request
  Then we expect callback request
  Then we send callback response with status code 201 and headers [content-type:application/json; location:subscriptions/<msisdn>] and content
 """
  {
    "subscription": {"eventList": [{"type": "REACHABILITY_REPORT", "reachabilityFilter": "UE_REACHABLE_DL_TRAFFIC"}],
    "options": {"trigger": "ONE_TIME"},
    "eventNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v2/amfnotif",
    "notifyCorrelationId": "msisdn-<msisdn>",
    "nfId": "841d1b7c-5103-11e9-8c09-174c95907e28",
    "subsChangeNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v1/amfsubsidchangenotif/msisdn-<msisdn>"},
    "subscriptionId":"http://udm.ericsson.se:8080/amf05/<msisdn>"
  }
  """
  Then we expect response status code 201
  Then we expect response time less than 2000 milliseconds

