Feature:  SMF registration data population

Scenario: Send TC-UDRSIM-0061
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/smf-registrations
   Given request header is Content-Type:application/json
   Given request content is

   """
   []
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
