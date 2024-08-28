Feature: Get NSSAI Autoprovisioning

#Provisioning script
#Not needed

#FT
#nghttp -v -t 1 -H':method: GET' 'http://localhost:30610/nudm-sdm/v2/imsi-240810000300000/nssai'

# Not working on 31_BETA24
#  Then we send default response with status code 200 and Cache-Control header equal to no-store and Pragma header equal to no-cache and content


# This is an asynchronous implementation of scenario where EDA token is handled.
# We are using a possitive scenario where token is sent in case request is received.
# For BAT, the idea is to use this scenario once autoprovisioning is integrated in BAT.
Scenario: Default callback handler initialization token
  Given callback request to server number 3 type GENERIC_HTTP
  Given callback request path prefix /oauth/v1/token
  Given action name is eric-udm-nudm-autoprov
  When we receive callback request
  Then we send default response with status code 200 and content
  """
  {
    "id_token":"aaaaaaaabbbbbbbbccccccccdddddddd",
    "access_token":"xxxxxxxxxxxyyyyyyyyyyzzzzzzzzzzz",
    "token_type":"bearer",
    "expires_in": 86400 ,
    "refresh_token":"my_refresh_token1",
    "scope":"EDA_local"
  }
  """

Scenario: Send GetNSSAI
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/nssai
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/json
  Given action name is GET-nssai
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
