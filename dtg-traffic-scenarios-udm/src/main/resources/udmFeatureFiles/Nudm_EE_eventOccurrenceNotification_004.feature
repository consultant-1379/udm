Feature: AMF Registration with visited plmnid

#Preconditions: (roamingFunctionEnabled=TRUE and Roaming is allowed from the PLMNID in registration message) or roamingFunctionEnabled=FALSE
#This scenario should be run after  NNudm_EE_CreateEeSubscription_002.featur and udm_EE_eventOccurrenceNotification_003.feature
#Callback will not sent in FT, because it needs a NEF server

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"guami":{"plmnId":{"mcc":"555","mnc":"666"},"amfId":"A1B2C3"},"amfInstanceId": "AMFID ID 01", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "ratType" : "NR" }' 'http://localhost:31380/nudm-uecm/v1/imsi-240810000000001/registrations/amf-3gpp-access'

Scenario: Default callback handler initialization
  Given callback request to server number 1 type GENERIC_HTTP
  Given callback request path prefix /MonitoringReport
  Given action name is default-notify-roaming-status-change
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Register-Amf3GPPAccess
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "guami": {"plmnId": {"mcc": "555", "mnc": "666"}, "amfId": "A1B2C3"},
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri",
    "ratType" : "NR"
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
