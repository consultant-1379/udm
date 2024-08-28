Feature: Report delivery status for SM with failure report (absent subscriber)

#delay is included

#UDM should be installed with amfproxy simulator enabled. add following lines in the command:
# --set eric-udm-amfproxy.env.simulator.endpoint="http://localhost:8093"
# --set eric-udm-amfproxy.env.simulator.enabled=true
#The endpoint should be updated with the AMF3 IP and port

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;MSISDN="msisdn-8608100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "'$IMSI'", "gpsi": "'$MSISDN'"}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$MSISDN'/id-translation-result';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}, "urrpIndicator": false}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"scAddressList": []}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/sms-waiting';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"scAddress": "02", "smsDeliveryOutcome": "ABSENT_SUBSCRIBER"}' 'http://localhost:31382/nudm-mtsms/v1/msisdn-860810000000000/delivery-status'
#The callback will not sent in FT as it needs a server

#No other scenarios execution dependencies

Scenario: Default callback handler initialization
  Given callback request to server number 3 type AMF_HTTP
  Given callback request path prefix /namf-evts/v1/subscriptions
  Given action name is AmfCreateEventSubscription
  When we receive callback request
  Then we send default response with status code 201 and content
  """
  {
    "subscription": {"eventList": [{"type": "REACHABILITY_REPORT"}],
    "options": {"trigger": "ONE_TIME"},
    "eventNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v2/amfnotif",
    "notifyCorrelationId": "imsi-<imsi>",
    "nfId": "2791337a-ecd6-4730-b2e1-dfdae3ea7042",
    "supi": "imsi-<imsi>",
    "gpsi": "msisdn-<msisdn>"},
    "subscriptionId":"subscriptionId",
    "reportList": 
      [{
        "type": "REACHABILITY_REPORT",
        "state": {"active": true},
        "supi": "imsi-<imsi>",
        "reachability": "REACHABLE",
        "timeStamp": "2019-08-07T10:11:34Z"
      }]
  }
  """

Scenario: Send Put_SmsDeliveryStatus
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-mtsms/v1/msisdn-<msisdn>/delivery-status
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "scAddress": "02",
    "smsDeliveryOutcome": "ABSENT_SUBSCRIBER"
  }
  """
  When we send PUT request
  Then we expect response status code 200
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
  Then Sleep for 1 seconds
