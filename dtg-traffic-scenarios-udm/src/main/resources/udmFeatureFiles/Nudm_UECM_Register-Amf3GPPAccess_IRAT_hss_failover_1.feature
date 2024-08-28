Feature: AMF 3GPP Access Registration AMF1 IRAT from LTE REL16(only for HSS failover testing)


Scenario: Default callback handler initialization
  Given action name is hss1-callback
  Given callback request to server number 2 type GENERIC_HTTP
  Given callback request path prefix /nhss-uecm/v1/deregister-sn
  Given callback request content before key imsi":"
  Given callback request content after key "
  Then we wait for callback request

Scenario: Send Register-Amf3GPPAccess-AMF1
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given action name is registration-amf1
  Given request content is
  """
  {
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri" : "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/",
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "ratType" : "NR",
    "initialRegistrationInd": true
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
  Given action name is callback
  Given callback handler action name is hss1-callback
  When we receive callback request
  Then we send response with status code 204





