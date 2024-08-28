#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends User DeProvisioning Notification

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /deregistration
  Given action name is default-amdata-change-notification-callback-amf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send UDR-DataChangeNotification-Amf3GPPAccess
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/"],
    "notifyItems": [{
      "resourceId": "http://udrsim:9082/nudr-dr/v2/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access",
      "changes": [{
  	    "op": "REMOVE",
        "path": "",
        "origValue": {
          "amfInstanceId": "1ae31336-b046-11e8-96f8-529269fb0001",
          "pei": "imei-899990000<pei>0",
          "deregCallbackUri": "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/",
          "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
          "ratType" : "NR"
        }
	    }]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
