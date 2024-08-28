#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends SMF Selection Data Change Notification With Wrong AMF Port

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
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
    "originalCallbackReference": ["<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:9090/sdmDataChange/imsi-<imsi>/"],
    "notifyItems":[{
      "resourceId": "http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/smf-selection-subscription-data",
      "changes": [
	      {
    	    "op": "REPLACE",
   	      "path": "/subscribedSnssaiInfos/dnnInfos/defaultDnnIndicator",
    	    "origValue": true,
    	    "newValue": false
        },
  	    {
          "op": "REPLACE",
          "path": "/subscribedSnssaiInfos/dnnInfos/dnn",
          "origValue": "ericsson-network",
          "newValue": "ericsson-5g-network"
        },
	      {
          "op": "REPLACE",
          "path": "/subscribedSnssaiInfos/dnnInfos/iwkEpsInd",
          "origValue": true,
          "newValue": false
        },
        {
          "op": "REPLACE",
          "path": "/subscribedSnssaiInfos/dnnInfos/ladnIndicator",
          "origValue": false,
          "newValue": true
        },
        {
          "op": "REPLACE",
          "path": "/subscribedSnssaiInfos/dnnInfos/lboRoamingAllowed",
          "origValue": true,
          "newValue": false
        },
        {
          "op": "REPLACE",
          "path": "/subscribedSnssaiInfos/singleNssai/sd",
          "origValue":  "000001",
          "newValue":  "000011"
        },
        {
          "op": "REPLACE",
          "path": "/subscribedSnssaiInfos/singleNssai/sst",
          "origValue": 2,
          "newValue": 1
        }
      ]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
