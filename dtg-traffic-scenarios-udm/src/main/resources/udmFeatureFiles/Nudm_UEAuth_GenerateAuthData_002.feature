Feature: GenerateAuthData

#Provisioning script
#for i in {00000..00099};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "EAP_AKA_PRIME", "eKi": "IgCqNNQMCQ1tTDt3Y4VK+w==", "amfValue": 47545, "fsetInd": 0, "eOPc": "evmKBuqGq4szd9J64ImjpA==", "seqHe": "AAAAAAAA", "ind5gAusf": 25, "a4KeyInd": 1, "indCscf": 0}' 'http://127.0.0.1:30082/nudr-dr/v1/subscription-data/'$IMSI'/authentication-data'
#for i in {00000..00099};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "5G_AKA", "eKi": "IgCqNNQMCQ1tTDt3Y4VK+w==", "amfValue": 47545, "fsetInd": 0, "eOPc": "evmKBuqGq4szd9J64ImjpA==", "seqHe": "AAAAAAAA", "ind5gAusf": 25,"a4KeyInd": 1}' 'http://localhost:30081/nudr-dr/v1/subscription-data/'$IMSI'/authentication-data'

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"servingNetworkName": "5G:mnc222.mcc111.3gppnetwork.org","ausfInstanceId" : "cb11093e-5408-4729-9636-21f537e6d06f"}' 'http://seliius07335.seli.gic.ericsson.se:32657/nudm-ueau/v1/suci-0-240-81-0000-0-0-0000000001/security-information/generate-auth-data'

#No other scenarios execution dependencies

Scenario: Send GenerateAuthData
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given suci computed using Convert-IMSI-to-SUCI algorithm
  Given path is /nudm-ueau/v1/suci-<suci>/security-information/generate-auth-data
  Given request header is Content-Type:application/json
  Given action name is POST-generate-auth-data-suci
  Given request content is
  """
  {
    "servingNetworkName" : "5G:mnc222.mcc111.3gppnetwork.org",
    "ausfInstanceId" : "cb11093e-5408-4729-9636-21f537e6d06f"
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
