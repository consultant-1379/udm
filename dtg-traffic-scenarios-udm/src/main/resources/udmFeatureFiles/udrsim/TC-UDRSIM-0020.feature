Feature:  SMF selection subscription data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"subscribedSnssaiInfos": {"2-000002":{"dnnInfos": [{"defaultDnnIndicator": true, "dnn": "ericsson-network", "lboRoamingAllowed": true, "iwkEpsInd": true}]}}}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00020/111222/provisioned-data/smf-selection-subscription-data'

Scenario: Send TC-UDRSIM-0020
  Given target type is UDR_HTTP
  Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/smf-selection-subscription-data
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "subscribedSnssaiInfos": {
      "2-000002": {
        "dnnInfos": [{
          "defaultDnnIndicator": true,
          "dnn": "ericsson-network",
          "lboRoamingAllowed": true,
          "iwkEpsInd": true,
          "smfList": [
            "b20af4ca-72f5-4d53-8af4-f088bf28a901",
            "0c771380-9cc5-49c6-9876-aa2f5fa2a444"
          ],
          "sameSmfInd": true
        }]
      }
    }
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
