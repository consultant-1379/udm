#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends ue-context-in-smf-data Data Change Notification


Scenario: Send UDR-DataChangeNotification-ue-context-in-smf-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["http://214.1.158.12:9095/notifications/udm/sdm/v2/imsi-<imsi>/ue-context-in-smf-data"],
    "notifyItems":[{
      "resourceId": "http://udrsim:9082/nudr-dr/v2/subscription-data/imsi-<imsi>/context-data/smf-registrations",
      "changes":[{
  	    "op": "REPLACE",
        "path": "/1/",
        "origValue": {
          "PgwFqdn": "test_pgwFqdn",
          "epdgInd": "False",
          "plmnId": {"mcc": "460", "mnc": "01"} 
        },
      	"newValue": {
          "PgwFqdn": "other_pgwFqdn",
          "epdgInd": "True",
          "plmnId": {"mcc": "360", "mnc": "02"} 
        }
      }]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
