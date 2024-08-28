Feature: Get NSSAI Autoprovisioning

#Provisioning script
#Not needed

#FT
#nghttp -v -t 1 -H':method: GET' 'http://localhost:30610/nudm-sdm/v2/imsi-240810000330000/nssai'



# This is a synchronous implementation of scenario where only notification is expected. This can be
# used for initial verification of the feature. Once we are able to run load traffic for autoprovisioning,
# this scenario can be converted in an asynchronous one.
# Token will be handled in an additional possitive scenario "Nudm_SDM_GetNSSAI_EDA_Token.feature" where
# another asynchronous callback is implemented.


Scenario: Default callback handler initialization 2
  Given action name is eric-udm-nudm-autoprov-notif
  Given callback request to server number 3 type GENERIC_HTTP
  Given callback request path prefix /nact-autoprov/v1/
  When we receive callback request
  Then we send default response with status code 202 and content
  """
  {
    "response":"content_slice"
  }
  """


Scenario: Send GetNSSAI
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/nssai
  Given request header is Content-Type:application/json
  Given action name is GET-nssai
  When we send GET request
  Then we expect response status code 404
  Then we expect response time less than 2000 milliseconds
