Feature: UE reachability notification with SC Alert

#This scenario should be executed after Nudm_MTSMS_Put_SmsDeliveryStatus_002.feature or Nudm_MTSMS_Put_SmsDeliveryStatus_003.feature
#CM:
#get configuration
#curl -sS -i http://localhost:30891/cm/api/v1/configurations/ericsson-udm

#set ericsson-udm:udm-function/ProxyInterworking/enabled to true
#curl -D - -o - -sS -X PATCH -H "Content-Type: application/json" -d '[{"op":"replace", "path":"/ericsson-udm:udm-function/ProxyInterworking/enabled", "value":true }]' http://localhost:30891/cm/api/v1/configurations/ericsson-udm

#set ericsson-udm:udm-function/ProxyInterworking/AlertCallbackUri
#curl -D - -o - -sS -X PATCH -H "Content-Type: application/json" -d '[{"op":"replace", "path":"/ericsson-udm:udm-function/ProxyInterworking/AlertCallbackUri", "value":"http://150.132.165.173:8095/Alertcallback/uri" }]' http://localhost:30891/cm/api/v1/configurations/ericsson-udm
#the AlertCallbackUri should be updated with the GENERIC server IP and port

#restart pod eric-udm-alertsmssc to make the new configuration work

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;MSISDN="msisdn-8608100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "'$IMSI'", "gpsi": "'$MSISDN'"}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$MSISDN'/id-translation-result';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}, "urrpIndicator": false}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"scAddressList": []}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/sms-waiting';done

#FT:
#callback will not be sent out in FT as it needs a server
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"notifyCorrelationId": "imsi-240810000000000", "reportList": [{"type": "REACHABILITY_REPORT", "state": {"active": false}, "supi": "imsi-240810000000000", "reachability": "REACHABLE","timeStamp": "2019-08-07T10:11:34Z"}]}' 'http://localhost:31382/nudm-notifications/v2/amfnotif'


Scenario: Send AmfEventNotification
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v1/amfnotif
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "notifyCorrelationId":"imsi-<imsi>",
    "reportList": [{"type": "REACHABILITY_REPORT", "state": {"active": false}, "supi": "imsi-<imsi>", "reachability": "REACHABLE","timeStamp": "2022-03-15T10:11:34Z"}]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
