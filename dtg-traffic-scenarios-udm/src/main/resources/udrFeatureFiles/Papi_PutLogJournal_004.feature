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
              "/subscribers/<mscidprefix><mscid>/authSubscription/imsi-<imsi>": {
                "authSubscriptionStaticData": {},
                "authSubscriptionDynamicData": {}
              },
              "/subscribers/<mscidprefix><mscid>/authSubscription/msisdn-<msisdn>": {
                "authSubscriptionStaticData": {},
                "authSubscriptionDynamicData": {}
              }
            }
          ],
          "wantedState": [
            {
              "/subscribers/<mscidprefix><mscid>/authSubscription/imsi-<imsi>": {
                "authSubscriptionStaticData": {
                  "authenticationMethod": "5G_AKA",
                  "encPermanentKey": "22B3AA34D40C090D6D4C3B7763854AFB",
                  "authenticationManagementField": "B9B9",
                  "algorithmId": "0",
                  "a4KeyInd": "2",
                  "a4Ind": "2"
                },
                "authSubscriptionDynamicData": {
                  "sqnScheme": "NON_TIME_BASED",
                  "sqn": "000000000000",
                  "lastIndexes": {
                    "s-cscf": 30
                  }
                }
              },
              "/subscribers/<mscidprefix><mscid>/authSubscription/msisdn-<msisdn>": {
                "authSubscriptionStaticData": {
                  "authenticationMethod": "5G_AKA",
                  "encPermanentKey": "22B3AA34D40C090D6D4C3B7763854AFB",
                  "authenticationManagementField": "B9B9",
                  "algorithmId": "0",
                  "a4KeyInd": "2",
                  "a4Ind": "2"
                },
                "authSubscriptionDynamicData": {
                  "sqnScheme": "NON_TIME_BASED",
                  "sqn": "000000000000",
                  "lastIndexes": {
                    "s-cscf": 30
                  }
                }
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
