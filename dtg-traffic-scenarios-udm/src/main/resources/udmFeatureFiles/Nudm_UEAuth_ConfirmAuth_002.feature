Feature: ConfirmAuth

#Provisioning script
#for i in {00001..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authType": "5G_AKA", "nfInstanceId": "instanceId", "success": true, "timeStamp": "2000-01-01 12:00:00"}' 'http://127.0.0.1:30082/nudr-dr/v1/subscription-data/'$IMSI'/auth-event'

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"nfInstanceId": "68ffebdc-8299-11e8-adc0-fa7ae01bbebc", "success": true, "timeStamp": "2018-07-07T17:32:28Z", "authType": "5G_AKA", "servingNetworkName" : "5G:mnc015.mcc234.3gppnetwork.org"}' 'http://localhost:32657/nudm-ueau/v1/imsi-240810000000001/auth-events'

#No other scenarios execution dependencies

Scenario: Send ConfirmAuth
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ueau/v1/imsi-<imsi>/auth-events
  Given timestamp computed using Current-Time algorithm
  Given action name is POST-auth-events-5G-aka
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "nfInstanceId" : "68ffebdc-8299-11e8-adc0-fa7ae01bbebc",
    "success" : true,
    "timeStamp" : "<timestamp>",
    "authType" : "5G_AKA",
    "servingNetworkName" : "5G:mnc015.mcc234.3gppnetwork.org"
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then we expect response time less than 2000 milliseconds
