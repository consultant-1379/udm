Feature: AMF 3GPP Access Registration AMF1 IRAT from LTE


Scenario: prepare for incoming Cancel-Location-Request from HSS
  Given Incoming Diameter Cancel-Location-Request target type is EPC
  Given Incoming Diameter Cancel-Location-Request application is S6a
  Given Incoming Diameter Cancel-Location-Request key AVP is User-Name
  When we receive incoming Diameter Cancel-Location-Request for <imsi>
  Then save Incoming Diameter Cancel-Location-Request AVP Session-Id value as sessionId
  Then we send Diameter answer for Cancel-Location-Request with AVPs:
  """
    [
      { "name":"Session-Id", "value":"<sessionId>" },
      { "name":"Auth-Session-State", "value":1 },
      { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST>" },
      { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM>" },
      { "name":"Result-Code", "value":2001 }
    ]
  """

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
    "initialRegistrationInd" : true
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds

Scenario: wait for incoming Cancel-Location-Request from HSS
 Then we wait for Diameter Cancel-Location-Request for 10 seconds

