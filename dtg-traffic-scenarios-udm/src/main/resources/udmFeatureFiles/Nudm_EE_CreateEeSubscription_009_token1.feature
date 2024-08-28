Feature: EE subscription (Event Type =  UE Reachability for SMS)


Scenario: Send CreateEeSubscription
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ee/v1/msisdn-<msisdn>/ee-subscriptions
  Given request header is Authorization:Bearer <token_ee>
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "callbackReference": "<GENERIC_SERVER_SCHEME(6)>://<GENERIC_SERVER_ADDRESS(6)>:<GENERIC_SERVER_PORT(6)>/nef01/callback/uri/callbackUri",
    "monitoringConfigurations": {"<RANDOM_VALUE>": {"eventType":"UE_REACHABILITY_FOR_SMS","reachabilityForSmsCfg":"REACHABILITY_FOR_SMS_OVER_NAS"}
                                  },
    "reportingOptions" : {"reportMode":"ON_EVENT_DETECTION",
                          "maxNumOfReports":1,
                          "expiry":"2030-11-30T23:59:59Z"}
   }
  """
  When we send POST request
  Then we expect response status code 201
  Then we expect response time less than 2000 milliseconds
