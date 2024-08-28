Feature: SDM-Datachange SMF Data Callback

#This scenario should be run after Nudm_SDM_Subscribe-SDM-Datachange_002.feature

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"ueId": "imsi-<imsi>","originalCallbackReference":["<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/"],"notifyItems":[{"resourceId": "http://udm.ericsson.se:1234/nudm-sdm/v2/imsi-<imsi>/am-data","changes": [{"op": "REMOVE", "path":"/subscribedSnssaiInfos/dnnInfos","origValue":[{"defaultDnnIndicator": "True","dnn": "ericsson-network","lboRoamingAllowed": "True"}]}]}'  'http://localhost:30082/nudm-notifications/v2/sdm'

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /sdmDataChange
  Given action name is subscription-callback-amf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Notification of SMF Selection Data Change
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/"],
    "notifyItems": [{
      "resourceId": "http://udm.ericsson.se:1234/nudm-sdm/v2/imsi-<imsi>/smf-select-data",
      "changes": [{
        "op": "REMOVE",
        "path":"/subscribedSnssaiInfos/dnnInfos",
        "origValue": [{
          "defaultDnnIndicator": "True",
          "dnn": "ericsson-network",
          "lboRoamingAllowed": "True"
        }]
      }]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
