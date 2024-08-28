Feature: AMF 3GPP Access Registration AMF1 Autoprovisioning

#Provisioning script
#Not needed

#FT

# This is an asynchronous implementation of scenario where only notification is expected.
# Token will be handled in an additional possitive scenario "Nudm_SDM_GetNSSAI_EDA_Token.feature" where
# another asynchronous callback is implemented.
Scenario: Default callback handler initialization notif reg
  Given action name is eric-udm-nudm-autoprov-notif
  Given callback request to server number 3 type GENERIC_HTTP
  Given callback request path prefix /nact-autoprov/v1/
  When we receive callback request
  Then we send default response with status code 202 and content
  """
  {
    "response":"content_reg"
  }
  """

Scenario: Send Register-Amf3GPPAccess-AMF1
  Given action name is PUT-registration-amf1
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Authorization:Bearer <token_uecm>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri" : "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/",
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "ratType" : "NR",
    "isInHomePlmn" : true
  }
  """
  When we send PUT request
  Then we expect response status code 403
  Then we expect response time less than 2000 milliseconds
