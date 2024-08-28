Feature: AMF 3GPP Access Registration ROAMING PEI SENT

Scenario: Send Register-Amf3GPPAccess-Roaming-Pei
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri": "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/",
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "pei": "imei-99999000<pei>0",
    "ratType" : "NR",
    "drFlag" : true
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
