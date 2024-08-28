#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server

Feature: UDR Sends ue-context-in-smf-data Data Change Notification

Scenario: Default HSS callback handler initialization
  Given callback request to server number 4 type GENERIC_HTTP
  Given callback request path prefix /sdmDataChange
  Given callback request with before key imsi-
  Given callback request with after key /
  Given action name is default-callback-hss1
  Then we wait for callback request

Scenario: Send UDR-DataChangeNotification-ue-context-in-smf-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["<GENERIC_SERVER_SCHEME(4)>://<GENERIC_SERVER_ADDRESS(4)>:<GENERIC_SERVER_PORT(4)>/sdmDataChange/imsi-<imsi>/"],
    "notifyItems":[{
      "resourceId": "http://udrsim:9082/nudr-dr/v2/subscription-data/imsi-<imsi>/context-data/smf-registrations",
      "changes":[{
  	    "op": "REPLACE",
        "path": "/0/",
        "origValue": {
          "PgwFqdn": "test_pgwFqdn",
          "epdgInd": "True"
        },
      	"newValue": {
          "PgwFqdn": "test_pgwFqdn",
          "epdgInd": "False"
        }
      }]
    }]
  }
  """
  When we send POST request
  Then we expect callback request
  Then we send callback response with status code 204
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
