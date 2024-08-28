Feature: Subscription to AMF EventNotification

#Key verification is included.

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;MSISDN="msisdn-8608100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "'$IMSI'", "gpsi": "'$MSISDN'"}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$MSISDN'/id-translation-result';done
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri","guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"}, "ratType" : "NR" }' 'http://localhost:31382/nudm-uecm/v1/imsi-240810000000001/registrations/amf-3gpp-access'

Scenario: Wait reachability subscription
  Given callback request to server number 1 type GENERIC_HTTP
  Given callback request path prefix /namf-evts/v1/subscriptions
  Given action name is AmfCreateEventSubscription
  When we receive callback request
  Then we send default response with status code 201 and headers [content-type:application/json; location:https://amf01.ericsson.net/namf-evts/v1/subscriptions/111222333444] and content
  """
  {
    "subscriptionId" : "http://udm.ericsson.se:1234/nudm-notifications/v2/amfnotif",
    "subscription" : {"eventList": [{"type": "REACHABILITY_REPORT"}],
                     "options": {"trigger": "ONE_TIME"},
                     "eventNotifyUri": "http://udm.ericsson.se:1234/nudm-notifications/v2/amfnotif",
                     "notifyCorrelationId": "imsi-<imsi>",
                     "nfId": "2791337a-ecd6-4730-b2e1-dfdae3ea7042",
                     "supi": "imsi-<imsi>"}
  }
  """


# Based in https://gerrit-gamma.gic.ericsson.se/plugins/gitiles/HSS/CCSM/UDM/api/+/master/EIPS_Nudm_MTSMS.yaml
#Scenario: Send Report Delivery Status
#  Given target type is UDM_HTTP
#  Given target tag is HTTP_2
#  Given path is /nudm-mtsms/v1/imsi-<imsi>/routing-info
#  Given request header is Content-Type:application/json
#  Given request content is
#  """
#  {
#    "scAddress": "01",
#    "smsDeliveryOutcome": "ABSENT_SUBSCRIBER"
#  }
#  """
#  When we send PUT request
#  Then we expect response status code 200
#  Then we expect response time less than 2000 milliseconds

#curl --http2-prior-knowledge --verbose -i -m 3 -X PUT -H'content-type: application/json' -d '{"argument": "<ReportSM-DeliveryStatusArg> <msisdn>910110F0</msisdn> <serviceCentreAddress>9101</serviceCentreAddress> <sm-DeliveryOutcome> <absentSubscriber/> </sm-DeliveryOutcome> </ReportSM-DeliveryStatusArg>", "mapVersion": "V2"}' 'http://eric-ccsm-smsengine:9002/incoming/v1/delivery-status'  

# Based in https://gerrit-gamma.gic.ericsson.se/plugins/gitiles/HSS/CCSM/api/+/master/internal/eric-ccsm-smsengine-incoming.yaml 
#    "argument": "<ReportSM-DeliveryStatusArg>\<msisdn\>msisdn-<msisdn></msisdn><serviceCentreAddress>01</serviceCentreAddress><sm-DeliveryOutcome><absentSubscriber/></sm-DeliveryOutcome>\<imsi\>imsi-<imsi></imsi></ReportSM-DeliveryStatusArg>",
#860810001403000 is coded as 9168800100413000F0. 91 means 1001 0001. 1 -> No Extension, 001-> International Number , 0001->ISDN/Telephony Number Plan (REC E.164)
#86081001330000   -> 86 08 10 01 33 00 00 is coded as 91 68 80 01 10 33 00 00

#    "argument": "<ReportSM-DeliveryStatusArg>\<msisdn\>9168800110330000</msisdn><serviceCentreAddress>9101</serviceCentreAddress><singleAttemptDelivery>true</singleAttemptDelivery><sm-DeliveryOutcome><absentSubscriber/></sm-DeliveryOutcome></ReportSM-DeliveryStatusArg>",
#
Scenario: Send Report Delivery Status
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /incoming/v1/delivery-status
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "argument": "<ReportSM-DeliveryStatusArg>\<msisdn\>91688001103<msisdn></msisdn>\<imsi\>240081001330000</imsi><serviceCentreAddress>9101</serviceCentreAddress><singleAttemptDelivery>true</singleAttemptDelivery><sm-DeliveryOutcome><absentSubscriber/></sm-DeliveryOutcome></ReportSM-DeliveryStatusArg>",
    "mapVersion": "V2"
  }
  """
  When we send PUT request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
