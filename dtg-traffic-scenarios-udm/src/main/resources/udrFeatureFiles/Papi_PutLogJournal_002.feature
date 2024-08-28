Feature: Journal

Scenario: Create subscriber Journal
  Given target type is UDR_HTTP
  Given target tag is PAPI
  Given path is /papi/v1/subscribers/<mscidprefix><mscid>/journal/logJournal
  Given request header is Content-Type:application/json
  Given Content-Length is calculated automatically
  Given request content is
    """
    {
      "states": [
        {
          "stateId": 0,
          "currentState": [
            {
              "/subscribers/<mscidprefix><mscid>/udmSubscription/udmStaticAndRegistrationData": {
                "udmStaticData": null,
                "udmAccessRegistrationData": {}
              }
            }
          ],
          "wantedState": [
            {
              "/subscribers/<mscidprefix><mscid>/udmSubscription/udmStaticAndRegistrationData": {
                "udmStaticData": {
                  "subscribedUeAmbr": {
                    "uplink": "10.5 Mbps",
                    "downlink": "30 Gbps"
                  },
                  "forbiddenAreas": [
                    {
                      "id": "DefaultServiceArea2"
                    }
                  ],
                  "serviceAreaRestriction": {
                    "restrictionType": "ALLOWED_AREAS",
                    "areas": [
                      {
                        "id": "RoamingArea1"
                      }
                    ],
                    "maxNumOfTAs": 2
                  },
                  "mpsPriority": true,
                  "mcsPriority": true,
                  "dlPacketCount": 0,
                  "micoAllowed": true,
                  "udmSliceProfileId": {
                    "id": "SliceProfile1"
                  },
                  "staticIpAddress": {
                    "nssaiDnnIpLists": [
                      {
                        "nssai": {
                          "sst": 2,
                          "sd": "000002"
                        },
                        "dnnIpList": [
                          {
                            "dnn": "ericsson-network",
                            "ipAddress": [
                              {
                                "ipv4Addr": "198.51.100.1",
                                "ipv6Addr": "2001:db8:85a3::8a2e:370:7334"
                              }
                            ]
                          },
                          {
                            "dnn": "service1",
                            "ipAddress": [
                              {
                                "ipv4Addr": "198.51.100.2",
                                "ipv6Addr": "2001:db8:85a3::8a2e:370:7335"
                              }
                            ]
                          },
                          {
                            "dnn": "service2",
                            "ipAddress": [
                              {
                                "ipv4Addr": "198.51.100.2"
                              }
                            ]
                          }
                        ]
                      },
                      {
                        "nssai": {
                          "sst": 1,
                          "sd": "000001"
                        },
                        "dnnIpList": [
                          {
                            "dnn": "internet",
                            "ipAddress": [
                              {
                                "ipv4Addr": "198.51.100.1",
                                "ipv6Addr": "2001:db8:85a3::8a2e:370:7334"
                              }
                            ]
                          },
                          {
                            "dnn": "service1",
                            "ipAddress": [
                              {
                                "ipv4Addr": "198.51.100.2",
                                "ipv6Addr": "2001:db8:85a3::8a2e:370:7335"
                              }
                            ]
                          },
                          {
                            "dnn": "service2",
                            "ipAddress": [
                              {
                                "ipv4Addr": "198.51.100.2"
                              }
                            ]
                          }
                        ]
                      }
                    ]
                  },
                  "ueUsageType": 1,
                  "rfspIndex": 100,
                  "subsRegTimer": 1000
                },
                "udmAccessRegistrationData": {}
              }
            }
          ]
        }
      ],
      "index": {
        "stagedStateIds": [
          0
        ],
        "atRest": false
      }
    }
    """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds