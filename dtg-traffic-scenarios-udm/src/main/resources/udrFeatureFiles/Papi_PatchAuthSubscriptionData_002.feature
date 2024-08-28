Feature: Authentication Subscription

Scenario: Create subscriber Authentication Subscription Data
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
        "value": "Creation of AuthSubscription data"
      },
      {
        "op": "add",
        "path": "/authSubscription/imsi-<imsi>",
        "value": {
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
    """
  When we send PATCH request
  Then we expect response status code 200
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
