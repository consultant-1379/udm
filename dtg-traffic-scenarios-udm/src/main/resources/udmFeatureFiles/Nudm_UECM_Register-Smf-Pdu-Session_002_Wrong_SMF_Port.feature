Feature: SMF Registration

Scenario: Send Register-Smf With Wrong SMF Port
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/smf-registrations/<pduSessionId>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "smfInstanceId":"e09ea573-2ac3-4c22-8def-e2a992ae6da4",
    "dnn":"ims",
    "pduSessionId":<pduSessionId>,
    "plmnId": {"mcc": "111", "mnc": "222"},
    "pcscfRestorationCallbackUri" : "<SMF_SERVER_SCHEME>://<SMF_SERVER_ADDRESS>:9094/pcscfrestoration/imsi-<imsi>/",
    "singleNssai": {"sd": "000002", "sst": 2}
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
