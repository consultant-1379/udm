Feature: User moves from 5G to 4G (Cancel 5G location) REL16

# Keys verification included
# This scenario will be run after Nudm_UECM_Register-Amf3GPPAccess_011.feature
# FT can not be implemented with a curl client, because it needs a AMF server

#Before run this case, make sure hssIrat4g5g in configurations is enabled.
#curl -D - -o - -sS -X PATCH -H "Content-Type: application/json" -d '[{"op":"replace", "path":"/ericsson-udm:udm-function/hssIrat4g5g/enabled",
#"value":true},{"op":"replace", "path":"/ericsson-udm:udm-function/hssIrat4g5g/hssUri",
#"value":localhost:8098}]'  http://localhost:30087/cm/api/v1/configurations/ericsson-udm
#The value set for hssUri (the simulated HSS endpoint) correspond to HOST and PORT set in HSS1_Server.properties file in DTG

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "", "deregCallbackUri": "", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": true, "imsVoPS": "HOMOGENEOUS_SUPPORT","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""} }' 'http://localhost:30098/nudr-dr/v1/subscription-data/$IMSI/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data'; done


#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X DELETE -H'content-type:application/json' ' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000100/registrations/amf-3gpp-access/dereg-amf'

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /deregistration
  Given callback request with before key imsi-
  Given callback request with after key /
  Given action name is deregistration-callback-rel16-amf1
  When we receive callback request
  Then we send default response with header content-type:application/json and status code 204

Scenario: Send irat_mobility_udm
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access/dereg-amf
  Given request header is Authorization:Bearer <token_uecm>
  Given request header is Content-Type:application/json
  Given action name is irat-mobility-rel16-to-4g
  Given request content is
  """
  {
    "deregReason": "5GS_TO_EPS_MOBILITY"
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
