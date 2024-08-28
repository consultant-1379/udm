Feature:  Access mobility data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"gpsis": ["msisdn-00010"], "nssai": { "defaultSingleNssais": [{"sd": "000002", "sst": 2}],  "singleNssais": [{"sd": "000001", "sst": 2}]}, "ratRestrictions": ["EUTRA", "VIRTUAL"], "rfspIndex": 128, "subsRegTimer": 30571699, "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"}, "ueUsageType": 162892183, "coreNetworkTypeRestrictions": ["EPC", "5GC"], "forbiddenAreas": [ {"areaCode": "SH001"},  {"areaCode": "AB001"}], "serviceAreaRestriction": { "restrictionType": "ALLOWED_AREAS",  "areas": [  {"tacs": ["ac1236", "ac2346", "ac3456"]}],  "maxNumOfTAs": 4}, "mpsPriority": true, "micoAllowed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00010/111222/provisioned-data/am-data'

Scenario: Send TC-UDRSIM-0010
  Given target type is UDR_HTTP
  Given path is /nudr-dr/v2/subscription-data/imsi-<imsi>/111222/provisioned-data/am-data
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "gpsis": ["msisdn-<msisdn>"],
    "nssai": {
      "defaultSingleNssais": [{"sd": "000002", "sst": 2}],
      "singleNssais": [{"sd": "000001", "sst": 2}]
    },
    "ratRestrictions": ["EUTRA", "VIRTUAL"],
    "rfspIndex": 128,
    "subsRegTimer": 30571699,
    "subscribedUeAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"},
    "ueUsageType": 162892183,
    "coreNetworkTypeRestrictions": ["EPC", "5GC"],
    "forbiddenAreas": [
      {"areaCode": "SH001"},
      {"areaCode": "AB001"}
    ],
    "serviceAreaRestriction": {
      "restrictionType": "ALLOWED_AREAS",
      "areas": [
        {"tacs": ["ac1236", "ac2346", "ac3456"]}
      ],
      "maxNumOfTAs": 4
    },
    "mpsPriority": true,
    "mcsPriority": false,
    "micoAllowed": false
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
