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
  	    "op": "ADD",
        "path": "/1/",
        "newValue": {
           "smfInstanceId":"1ae31336-b046-11e8-96f8-529269fb0001",
           "dnn":"ericsson-network",
           "pduSessionId":1,
           "plmnId": {"mcc": "460", "mnc": "01"} ,
           "singleNssai": {"sd": "000002", "sst": 2},
           "pgwFqdn":"test_pgwFqdn",
           "epdgInd": false
        }
      }]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
