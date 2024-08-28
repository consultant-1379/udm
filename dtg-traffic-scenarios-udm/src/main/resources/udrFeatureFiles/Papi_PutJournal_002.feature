Feature: Journal

Scenario: Create subscriber Journal
  Given target type is UDR_HTTP
  Given target tag is PAPI
  Given path is /papi/v1/subscribers/<mscidprefix><mscid>/journal
  Given request header is Content-Type:application/json
  Given Content-Length is calculated automatically
  Given request content is
    """
    {
      "provJournal": {
        "notifRef": "NotifRef0001",
        "imsi": "<imsi>",
        "imsiMask": "0b0000000000100000",
        "imsiExtMask": "0b00000000000000100000000000000010",
        "msisdn": "<msisdn>",
        "msisdnMask": "0b0000000000100000",
        "msisdnExtMask": "0b00000000000000100000000000000010",
        "imsiAux": "214021000000",
        "imsiAuxMask": "0b0000000000100000",
        "imsiAuxExtMask": "0b00000000000000100000000000000010",
        "impi": "240811000000001@ericsson.se",
        "impiMask": "0b0000000000100000",
        "impiExtMask": "0b00000000000000100000000000000010",
        "trafficIdList": [],
        "secImpi": "240812000000001@ericsson.se",
        "impiAux": "240813000000001@ericsson.se",
        "username": "USERNAME0001",
        "usernameMask": "0b0000000000100000",
        "usernameExtMask": "0b00000000000000100000000000000010",
        "imsiChoStatus": 2,
        "imsiExpiryDate ": "01012020",
        "impuChoIds": [
          "tel:340000000$tel:340000001",
          "tel:340000002$tel:340000003"
        ],
        "mscIdAux": "10000000000000000000000000001",
        "notifInfo": "notifInfo0001",
        "ueFunctionMask": "0b0000000000000000000000000000000000000000000000000000000000000000",
        "subsIdList": [
          {
            "id": "imsi-<imsi>",
            "prefix": "imsi"
          },
          {
            "id": "msisdn-<msisdn>",
            "prefix": "msisdn"
          }
        ]
      },
      "logJournal": {
      }
    }
    """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
