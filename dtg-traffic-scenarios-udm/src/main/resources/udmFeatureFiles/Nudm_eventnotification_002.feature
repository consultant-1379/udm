Feature: UDM150-EE-UE-Reachability-for-SMS

Scenario: Default callback handler initialization
  Given action name is Reachability_for_SMS_Callback_AMF_NEF2
  Given callback request to server number 6 type GENERIC_HTTP
  Given callback request HTTP method POST
  Given callback request path prefix /nef01/callback/uri/callbackUri
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send AmfEventNotification
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v1/eenotif
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "notifyCorrelationId":"imsi-<imsi>",
    "reportList": [{"type": "REACHABILITY_REPORT", "state": {"active": false}, "supi": "imsi-<imsi>", "reachability": "REACHABLE","timeStamp": "2023-07-15T10:11:34Z"}]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
