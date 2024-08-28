Feature: UDM153-EE-Roaming_Status_Change

Scenario: Default callback handler initialization
  Given action name is RoamingStatus_Callback_AMF_NEF1
  Given callback request to server number 5 type GENERIC_HTTP
  Given callback request path prefix /nef01/callback/uri/callbackUri
  Given callback request HTTP method POST
  When we receive callback request
  Then we send default response with status code 204

Scenario: Default callback handler initialization
  Given callback request to server number 10 type AMF_HTTP
  Given callback request path prefix /deregistration
  Given callback request with before key imsi-
  Given callback request with after key /
  Given action name is EE-Roaming-deregistration-callback-amf10
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Register-Amf3GPPAccess
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given action name is AMF1-REGISTRATION
  Given request content is
  """
  {
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri": "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/",
    "ratType" : "NR"
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
