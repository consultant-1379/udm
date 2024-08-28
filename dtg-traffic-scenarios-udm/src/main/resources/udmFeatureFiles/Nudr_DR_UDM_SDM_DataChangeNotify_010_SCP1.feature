#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends AM Data Change Notification

Scenario: Default callback handler initialization
  Given callback request to server number 1 type GENERIC_HTTP
  Given callback request path prefix /sdmDataChange
  Given callback request with before key imsi-
  Given callback request with after key /
  Given action name is default-amdata-change-notification-callback-scp1
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
    "originalCallbackReference": ["<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/"],
    "sdmSubscription" : {
      "nfInstanceId" : "1ec823fe-4a62-4617-aabf-55d14627a3dd",
      "callbackReference" : "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/",
      "monitoredResourceUris" : ["<UDM_CLIENT_SCHEME>://<UDM_CLIENT_DESTINATION_HOST>:<UDM_CLIENT_DESTINATION_PORT>/nudm-sdm/v2/imsi-<imsi>/am-data"],
      "plmnId": {"mcc": "111", "mnc": "222"}
    },
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
