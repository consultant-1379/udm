Feature: Get CM_GET_LOCATION
#This script is based in Nudm_voice_CM_GET_003.feature but using http2 so traffic is more stable for overload test.

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": false, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done


#FT:
#curl --http1.1 -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:31382/nudm-voice-uecm/v1/imsi-240810000000001/context-data?dataRef=LOCATION'
#callback will not be sent in FT as it needs a AMF server
#If AMF server is not started,the scenario still can pass and UDM will return the amfId which get form UDR

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

Scenario: Send Nudm-voice_CM_GET-LOCATION
  Given target type is UDM_HTTP
  Given target tag is HTTP_2_PLAIN
  Given path is /nudm-voice-uecm/v1/imsi-<imsi>/context-data?dataRef=LOCATION
  Given request header is Content-Type:application/json
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
