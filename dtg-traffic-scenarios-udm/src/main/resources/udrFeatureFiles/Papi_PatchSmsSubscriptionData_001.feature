Feature: SMS Subscription

Scenario: Create subscriber SMS Subscription Data
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
        "value": "Creation of SmsSubscription data"
      },
      {
        "op": "add",
        "path": "/smsSubscription/smsStaticAndRegistrationData",
        "value": {
            "smsStaticData": {
              "smsSubscriptionData": {
                "smsSubscribed": true
              },
              "smsManagementSubscriptionData": {
                "mtSmsSubscribed": true,
                "mtSmsBarringAll": false,
                "mtSmsBarringRoaming": false,
                "moSmsSubscribed": true,
                "moSmsBarringAll": false,
                "moSmsBarringRoaming": false
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
