Feature: AMF authentication Initiation Request Autoprovisioning

#Provisioning script
#No provisioning needed.

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supiOrSuci":"imsi-240810000450001","servingNetworkName":"5G:mnc222.mcc111.3gppnetwork.org"}' 'http://localhost:31384/nausf-auth/v1/ue-authentications'

# This is a synchronous implementation of scenario where both token and notification is expected. This can be
# used for initial verification of the feature, although I am not sure if we will able to handle the two requests properly or
# if execution will fail if only notification request is received. In case so, we might leave only notification callback as we do
# for slice scenario. Once we are able to run load traffic for autoprovisioning, this scenario can be converted in an asynchronous
# one and token can be handled in an additional possitive scenario "Nudm_SDM_GetNSSAI_EDA_Token.feature" where another asynchronous
# callback is implemented.
Scenario: Default callback handler initialization 2
  Given action name is eric-udm-nudm-autoprov-notif
  Given callback request to server number 3 type GENERIC_HTTP
  Given callback request path prefix /nact-autoprov/v1/
  When we receive callback request
  Then we send default response with status code 202 and content
  """
  {"response":"content_auth"}
  """

Scenario: Authentication Initiation Request
  Given action name is POST-authentication-eap-aka
  Given target type is AUSF_HTTP
  Given path is /nausf-auth/v1/ue-authentications
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
  "supiOrSuci":"imsi-<imsi>",
  "servingNetworkName":"5G:mnc222.mcc111.3gppnetwork.org"
  }
  """
  When we send POST request
  Then we expect response status code 403
  Then we expect response time less than 2000 milliseconds
