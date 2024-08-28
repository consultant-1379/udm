Feature: Get CM_GET_LOCATION

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": false, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done


#FT:
#curl -k -i -m 1 -X POST -H'content-type:application/json' -d '{"req5gsLoc": "true","reqCurrentLoc": "true","reqRatType": "true","reqTimeZone": "true","reqServingNode": "false"}' 'http://localhost:30096//nudm-mt/v1/imsi-240810000000000/loc-info/provide-loc-info'




Scenario: Default callback handler initialization
  Given callback request to server number 3 type AMF_HTTP
  Given callback request path prefix /namf-loc/v1/
  When we receive callback request
  Then we send default response with status code 200 and header content-type:application/json and content
  """
  {
    "currentLoc": true,
    "location": {"nrLocation": {"tai": {"plmnId": {"mcc": "111", "mnc": "222"}, "tac": "Aa19"}, "ncgi": {"plmnId": {"mcc": "111", "mnc": "222"}, "nrCellId": "9B1b0FfAa"}}},
    "locationAge": 32767,
    "ratType": "NR"
  }
  """

Scenario: Send Nudm-mt_POST-LOCATION
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given action name is nudm-mt-post-location-rel16
  Given path is /nudm-mt/v1/imsi-<imsi>/loc-info/provide-loc-info
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "req5gsLoc": true,
    "reqCurrentLoc": true,
    "reqRatType": true,
    "reqTimeZone": true,
    "reqServingNode": false
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
