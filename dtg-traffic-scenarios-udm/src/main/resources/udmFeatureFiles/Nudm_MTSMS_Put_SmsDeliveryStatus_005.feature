Feature: Inform Subscriber reachability

#UDM should be installed with amfproxy simulator enabled. add following lines in the command:
# --set eric-udm-amfproxy.env.simulator.endpoint="http://localhost:8090"
# --set eric-udm-amfproxy.env.simulator.enabled=true
#The endpoint should be updated with the AMF1 IP and port

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;MSISDN="msisdn-8608100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "'$IMSI'", "gpsi": "'$MSISDN'"}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$MSISDN'/id-translation-result';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}, "urrpIndicator": false}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"scAddressList": []}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/sms-waiting';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{	"notifyCorrelationId": "imsi-<imsi>","reportList":[	"type": "REACHABILITY_REPORT","state": { "active": false },"timeStamp": <Date>,"supi": "imsi-<imsi>","reachability": "REACHABLE"]}' 'http://localhost:31382/nudm-mtsms/v1/msisdn-860810000000000/delivery-status'
#The callback will not sent in FT as it needs a server

#No other scenarios execution dependencies

Scenario: Send Put_SmsDeliveryStatus
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v2/amfnotif
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "notifyCorrelationId": "imsi-<imsi>",
	  "reportList":
	    [
        "type": "REACHABILITY_REPORT",
		    "state": { "active": false },
		    "timeStamp": <Date>,
		    "supi": "imsi-<imsi>",
		    "reachability": "REACHABLE"
	    ]
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
