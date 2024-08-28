#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server
Feature: UDR Sends SM Data Change Notification With Wrong SMF Port

Scenario: Default callback handler initialization
  Given callback request to server number 1 type SMF_HTTP
  Given callback request path prefix /sdmDataChange
  Given action name is default-smdata-change-notification-callback-smf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send UDR-DataChangeNotification-SmData
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["<SMF_SERVER_SCHEME>://<SMF_SERVER_ADDRESS>:9094/sdmDataChange/imsi-<imsi>/"],
    "notifyItems": [{
      "resourceId": "http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/sm-data",
      "changes": [{
        "op": "REPLACE",
        "path": "/dnnConfiguration",
        "origValue": {
		    	"ericsson-network": [{
	          "dnn": "ericsson-network"
			    }],
			    "defaultSingleNssais": [{
			      "sd": "000002", "sst": 2
          }],
			    "singleNssais": [{
			      "sd": "000001", "sst": 2
          }]
        },
        "newValue": {
          "ericsson-network": [{
            "dnn": "ericsson-5g-network"
          }],
  		 	  "defaultSingleNssais": [{
			      "sd": "000012", "sst": 2
          }],
		      "singleNssais": [{
		        "sd": "000011", "sst": 2
          }]
			  }
 		  }]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
