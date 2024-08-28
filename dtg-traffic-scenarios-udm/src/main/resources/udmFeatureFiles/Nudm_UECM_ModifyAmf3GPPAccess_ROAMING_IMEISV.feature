Feature: AMF 3GPP Access De-Registration ROAMING PEI(IMEISV FORMAT) SENT

#This scenario should be executed after Nudm_UECM_Register-Amf3GPPAccess_001.feature

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "pei": "", "lastAMFRegistrationTS": "", "purgeFlag": true, "imsVoPS": "HOMOGENEOUS_SUPPORT"}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/$IMSI/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PATCH -H'content-type:application/merge-patch+json' -d'{"purgeFlag": true, "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"}}' 'http://eric-udm-apigw:9088/nudm-uecm/v1/imsi-240810000000000/registrations/amf-3gpp-access'

Scenario: Send De-Register-Amf3GPPAccess-Roaming-Pei
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/merge-patch+json
  Given request content is
  """
  {
    "purgeFlag": true,
    "guami": {"plmnId": {"mcc": "555", "mnc": "666"}, "amfId": "A1B2C3"},
    "pei": "imeisv-99999000000<pei>"
  }
  """
  When we send PATCH request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
