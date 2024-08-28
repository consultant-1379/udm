#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends Network Initiated Deregistration

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /deregistration
  Given action name is default-deregistration-callback-amf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send UDR-Deregistration-rmContextRemoval
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
   """
    {"notifyItems":
      [
        {"resourceId": "http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access",
         "changes":
              [{"op": "REMOVE", "path": "", "origValue": {"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/", "ratType": "WLAN",
              "guami": {"plmnId": {"mcc": "444", "mnc": "555"}, "amfId": "A1B2C3"}}}]
         }
      ]
    }
   """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
