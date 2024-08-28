Feature: Generate authentication data for EPS-AKA

#Provisioning script
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "5G_AKA","encPermanentKey": "22B3AA34D40C090D6D4C3B7763854AFB","authenticationManagementField":"B9B9","algorithmId":"0","protectionParameterId": "1$2","sequenceNumber":{"indLength": 5,"sqnScheme": "NON_TIME_BASED","sqn": "000000000000","difSign": "NEGATIVE","lastIndexes":{"mme":28}}}' 'http://127.0.0.1:30082/nudr-dr/v2/subscription-data/imsi-240820000720000/authentication-data/authentication-subscription'

#FT
#curl -k -i -m 1 -X POST -H'content-type:application/json' -d'{"hssAuthType" : "EPS_AKA","numOfRequestedVectors" : 5,"servingNetworkId" : {"mcc": "234","mnc": "15"}}' 'http://127.0.0.1:31382/nudm-ueau/v1/imsi-240820000720000/hss-security-information/eps-aka/generate-av'

Scenario: Send GenerateAuthData for EPS-AKA
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ueau/v1/imsi-<PreImsi><ImsiBody><msisdn>/hss-security-information/eps-aka/generate-av
  Given request header is Content-Type:application/json
  Given action name is POST-generate-auth-data-eps-aka
  Given request content is
  """
  {
    "hssAuthType" : "EPS_AKA",
    "numOfRequestedVectors" : 5,
    "servingNetworkId" : {
      "mcc": "234",
      "mnc": "15"}
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
