Feature: AMF 3GPP Access Registration AMF2

#This scenario will be run after Nudm_UECM_Register-Amf3GPPAccess_011.feature
#deregCallbackUri must be updated with traffic generator IP and port

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "", "deregCallbackUri": "", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": true, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""} }' 'http://localhost:30098/nudr-dr/v1/subscription-data/$IMSI/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done


#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"amfInstanceId": "d3ae07bd-b710-4c70-9414-5efac33af027", "deregCallbackUri": "http://amf01.ericsson.net/deregistration/imsi-240810000000100/","guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"}}' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000100/registrations/amf-3gpp-access'

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /deregistration
  Given callback request with before key imsi-
  Given callback request with after key /
  Given action name is default-deregistration-callback-amf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Register-Amf3GPPAccess-AMF2
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given action name is PUT-registration-amf2
  Given request content is
  """
  {
    "amfInstanceId": "d3ae07bd-b710-4c70-9414-5efac33af027",
    "deregCallbackUri" : "<AMF_SERVER_SCHEME(2)>://<AMF_SERVER_ADDRESS(2)>:<AMF_SERVER_PORT(2)>/deregistration/imsi-<imsi>/",
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C4"},
    "ratType" : "NR",
    "drFlag" : true
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
