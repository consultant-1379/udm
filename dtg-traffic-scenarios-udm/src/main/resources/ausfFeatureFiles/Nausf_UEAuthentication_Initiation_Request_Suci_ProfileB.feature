Feature: AMF authentication Initiation Request with EAP-AKA (suci with protection schema 2)

Scenario: Authentication Initiation Request
  Given target type is AUSF_HTTP
  Given suci computed using Convert-IMSI-to-SUCI-Profile-2 algorithm
  Given path is /nausf-auth/v1/ue-authentications
  Given action name is POST-authentication-eap-aka-suci
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
  "supiOrSuci":"suci-<suci>",
  "servingNetworkName":"5G:mnc222.mcc111.3gppnetwork.org"
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then we expect response time less than 2000 milliseconds
  Then we expect response content text property authType equals EAP_AKA_PRIME
  Then extract path from URI in response content property _links.eap-session.href and save as authCtxId
  Then compute eapPayload using EAP-AKA-PRIME algorithm
