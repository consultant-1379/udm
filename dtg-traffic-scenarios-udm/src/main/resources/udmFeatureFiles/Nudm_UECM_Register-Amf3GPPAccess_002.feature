Feature: AMF Roaming

#This scenario will be run after the configuration. The configurations are:
# - roamingFunctionEnabled = true
# - homePlmn = [111222]

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; MSISDN="msisdn-8608100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["$IMSI"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"tacs": ["bc53", "5632", "bc5436", "bc3216"]},  {"areaCodes": "SH001"},  {"areaCodes": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]},   {"areaCodes": "SH004"},   {"areaCodes": "AB002"}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/am-data';done

#Configuration (restart pod uecmreg after the configuration):
#curl -D - -o - -sS -X PATCH -H "Content-Type: application/json" -d '[{"op":"replace", "path":"/ericsson-udm:udm-function/roaming/roamingFunctionEnabled", "value":true}]'  http://localhost:32127/cm/api/v1/configurations/ericsson-udm

#curl -D - -o - -sS -X PATCH -H "Content-Type: application/json" -d '[{"op":"replace", "path":"/ericsson-udm:udm-function/roaming/homePlmn", "value":[{"plmnId": "111222"}] }]'  http://localhost:32127/cm/api/v1/configurations/ericsson-udm

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"guami":{"plmnId":{"mcc":"111","mnc":"222"},"amfId":"A1B2C3"}, "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "ratType" : "NR"}' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000001/registrations/amf-3gpp-access'

#No other scenarios execution dependencies

Scenario: Send Register-Amf3GPPAccess With HPLMN
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/amf-3gpp-access
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri",
    "ratType" : "NR"
  }
  """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
