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
            "currentState": [],
            "wantedState": []
          }
        ],
        "index": {
          "stagedStateIds": [
            0
          ],
          "atRest": true
        }
    }
    """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds