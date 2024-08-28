Feature: EE subscription (Event Type = Subscribe Roaming Status change)


Scenario: Send TC-UDRSIM-CreateEeSuscription
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v2/subscription-data/msisdn-<msisdn>/context-data/ee-subscriptions
   Given request header is Content-Type:application/json
   Given request content is

   """
   {
    "callbackReference": "<GENERIC_SERVER_SCHEME(2)>://<GENERIC_SERVER_ADDRESS(2)>:<GENERIC_SERVER_PORT(2)>/nef01/callback/uri/callbackUri",
    "monitoringConfigurations": {"<RANDOM_VALUE>":{"eventType":"ROAMING_STATUS","immediateFlag":true}},
    "reportingOptions" : {"reportMode":"ON_EVENT_DETECTION",
                          "maxNumOfReports":200,
                          "expiry":"2030-12-30T23:59:59Z"}
   }
   """
   When we send POST request
   Then we expect response status code 201
   Then we expect response time less than 2000 milliseconds

