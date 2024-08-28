Feature: UDM151-AMF-REgistration-EE-UE-Reachability-for-SMS

Scenario: Default callback handler initialization
  Given callback request to server number 7 type GENERIC_HTTP
  Given callback request HTTP method POST
  Given callback request path prefix /nef01/callback/uri/callbackUri
  Given action name is EE-UE-Reachability-for-SMS-callback-NEF1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Register-AmfNef1-3GPPAccess-AMFNEF1
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given action name is PUT-registration-nefamf1
  Given request content is
  """
  {
    "amfInstanceId": "8ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri" : "<GENERIC_SERVER_SCHEME(5)>://<GENERIC_SERVER_ADDRESS(5)>:<GENERIC_SERVER_PORT(5)>/deregistration/imsi-<imsi>/",
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "ratType" : "NR"
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
