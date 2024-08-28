#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends AM Data Change Notification

Scenario: Default callback handler initialization
  Given callback request to server number 3 type AMF_HTTP
  Given callback request path prefix /sdmDataChange
  Given action name is default-amdata-change-notification-callback-amf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send UDR-DataChangeNotification-AmData
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["<AMF_SERVER_SCHEME(3)>://<AMF_SERVER_ADDRESS(3)>:<AMF_SERVER_PORT(3)>/sdmDataChange/imsi-<imsi>/"],
    "notifyItems": [{
      "resourceId": "http://udrsim:9082/nudr-dr/v2/subscription-data/imsi-<imsi>/111222/provisioned-data/am-data",
      "changes": [
        {
          "op": "REPLACE",
          "path": "/ratRestrictions",
          "origValue": ["EUTRA"],
          "newValue": ["EUTRA", "VIRTUAL"]
        },
        {
          "op": "REPLACE",
          "path": "/nssai",
          "origValue": {
            "defaultSingleNssais": [{ "sd": "000002", "sst": 2}],"singleNssais": [{ "sd": "000001", "sst": 2}]
          },
          "newValue": {
            "defaultSingleNssais": [{ "sd": "000012", "sst": 2}],"singleNssais": [{ "sd": "000011", "sst": 2}]
          }
        }
      ]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
