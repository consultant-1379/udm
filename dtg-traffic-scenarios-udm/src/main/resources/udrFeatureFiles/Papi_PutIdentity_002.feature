Feature: Identity

Scenario: Create subscriber Identity
  Given target type is UDR_HTTP
  Given target tag is PAPI
  Given path is /papi/v1/identities/msisdn-<msisdn>
  Given request header is Content-Type:application/json
  Given Content-Length is calculated automatically
  Given request content is
    """
    {
      "id": "msisdn-<msisdn>",
      "mscid": "<mscidprefix><mscid>",
      "prefix": "msisdn"
    }
    """
  When we send PUT request
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
