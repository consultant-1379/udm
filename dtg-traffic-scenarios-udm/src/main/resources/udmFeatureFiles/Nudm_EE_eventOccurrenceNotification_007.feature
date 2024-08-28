Feature: EE subscription (Event Type = Location Request)

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-24081000072"$i;MSISDN="msisdn-86081000072"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": $IMSI, "gpsi": $MSISDN}' 'http://localhost:30098/nudr-dr/v2/subscription-data/$IMSI/identity-data';done
#for i in {00000..00100};do IMSI="imsi-24081000072"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": true, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/$IMSI/context-data/amf-3gpp-access';done
#for i in {00000..00100};do IMSI="imsi-24081000072"$i;MSISDN="msisdn-86081000072"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": $IMSI, "gpsi": $MSISDN}' 'http://localhost:30098/nudr-dr/v1/subscription-data/$MSISDN/id-translation-result';done
#for i in {00000..00100};do MSISDN="msisdn-86081000072"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "registrationTime": "2019-03-22T09:14:00Z", "purgeFlag": false, "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"}, "ratType": "NR"}}' 'http://udrsim:9082//nudr-dr/v1/subscription-data/$MSISDN/context-data/amf-3gpp-access';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d '{ "reportList": [{"type": "SUBSCRIPTION_ID_CHANGE", "state": {"active": false}, "supi": "imsi-240810000720000", "timeStamp": "2022-08-31T10:11:34Z", "subscriptionId": "860810000720000"}]}' 'http://localhost:31382/nudm-notifications/v1/amfsubsidchangenotif/imsi-240810000720000'

Scenario: Send Subscription ID Change
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-notifications/v1/amfsubsidchangenotif/imsi-<imsi>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
   "subsChangeNotifyCorrelationId": "<subsChangeNotifyCorrelationId>",
   "reportList":
      [{"type": "SUBSCRIPTION_ID_CHANGE",
       "state": {"active": false},
       "supi": "imsi-<imsi>",
       "timeStamp": "2022-08-31T10:11:34Z",
       "subscriptionId": "<SavedSubscriptionId>"}]
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
