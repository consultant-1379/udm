Feature: SDM-Datachange SM Data Callback

#This scenario should be run after Nudm_SDM_Subscribe-SDM-Datachange_003.feature

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscriptionId": "", "callbackReference": "", "monitoredResourceUri": []}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/sub-data-subscriptions';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"ueId": "imsi-<imsi>","originalCallbackReference":["<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/"],"notifyItems":[{"resourceId": "http://udm.ericsson.se:1234/nudm-sdm/v2/imsi-<imsi>/am-data","changes": [{"op": "REPLACE", "path":"/dnnConfiguration/ericsson-network/5gQosProfile/5qi","newValue":[2]}]}]}'  'http://localhost:30082/nudm-notifications/v2/sdm'

Scenario: Default callback handler initialization
  Given callback request to server number 1 type SMF_HTTP
  Given callback request path prefix /sdmDataChange
  Given action name is subscription-callback-smf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Notification of Session Management Data Change
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/sdm
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "ueId": "imsi-<imsi>",
    "originalCallbackReference": ["<SMF_SERVER_SCHEME>://<SMF_SERVER_ADDRESS>:<SMF_SERVER_PORT>/sdmDataChange/imsi-<imsi>/"],
    "notifyItems": [{
      "resourceId": "http://udm.ericsson.se:1234/nudm-sdm/v2/imsi-<imsi>/sm-data",
      "changes": [{
        "op": "ADD",
        "path": "/dnnConfiguration/ericsson-network/5gQosProfile/5qi",
        "newValue": [2]
      }]
    }]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
