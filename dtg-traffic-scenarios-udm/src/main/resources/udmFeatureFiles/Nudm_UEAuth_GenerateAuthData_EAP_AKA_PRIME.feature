Feature: Generate authentication data for EAP-AKA-PRIME

#Provisioning script
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "EAP_AKA_PRIME","encPermanentKey": "22B3AA34D40C090D6D4C3B7763854AFB","authenticationManagementField": "B9B9","algorithmId": "0", "protectionParameterId": "1$2","sequenceNumber":{"indLength": 5,"sqnScheme": "NON_TIME_BASED","sqn": "000000000000","difSign": "NEGATIVE","lastIndexes":{ "wlan-aaa-server": 26}}}' 'http://127.0.0.1:30082/nudr-dr/v2/subscription-data/imsi-240820000700000/authentication-data/authentication-subscription'

#FT
#curl -k -i -m 1 -X POST -H'content-type:application/json' -d'{"hssAuthType" : "EAP_AKA_PRIME","numOfRequestedVectors" : 5,"anId" : "HRPD"}' 'http://127.0.0.1:31382/nudm-ueau/v1/imsi-240820000700000/hss-security-information/eap-aka-prime/generate-av'

Scenario: Send GenerateAuthData for EAP-AKA-PRIME
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-ueau/v1/imsi-<imsi>/hss-security-information/eap-aka-prime/generate-av
  Given request header is Content-Type:application/json
  Given action name is POST-generate-auth-data-eap-aka-prime
  Given request content is
  """
  {
    "hssAuthType" : "EAP_AKA_PRIME",
    "numOfRequestedVectors" : 5,
    "anId" : "HRPD"
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
