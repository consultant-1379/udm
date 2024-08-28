Feature: UDM Static Data

Scenario: Create subscriber UDM Static Data
  Given target type is UDR_HTTP
  Given target tag is PAPI
  Given path is /papi/v1/subscribers/<mscidprefix><mscid>
  Given request header is Content-Type:application/json
  Given Content-Length is calculated automatically
  Given request content is
    """
    [
      {
        "op": "replace",
        "path": "/journal/provJournal/notifInfo",
        "value": "Creation of UDM subscription data"
      },
      {
        "op": "add",
        "path": "/udmSubscription/udmStaticAndRegistrationData/udmStaticData",
        "value": {
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
        }
      }
    ]
    """
  When we send PATCH request
  Then we expect response status code 200
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds