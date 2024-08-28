Feature: AMF 3GPP Access Registration NOT ROAMING with PEI included

Scenario: Send Register-Amf3GPPAccess-Not-Roaming-PEI-included
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/merge-patch+json
  Given request content is
  """
  {
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "pei": "imei-899990000<pei>0"
  }
  """
  When we send PATCH request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
