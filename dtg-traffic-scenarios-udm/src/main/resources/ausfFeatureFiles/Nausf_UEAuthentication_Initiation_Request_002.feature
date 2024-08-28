Feature: AMF authentication Initiation Request with 5G-AKA

#Provisioning script
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authenticationMethod": "5G_AKA", "eKi": "IrOqNNQMCQ1tTDt3Y4VK+w==", "amfValue": 47545, "fsetInd": 0,"seqHe": "AAAAAAAA", "ind5gAusf": 25, "a4KeyInd": 1, "indCscf": 0}' 'http://localhost:30082/nudr-dr/v1/subscription-data/imsi-240810000000001/authentication-data'

#FT
#curl --http2-prior-knowledge --cacert src/main/resources/certificates/SAN/DTG/ca/ca-chain.cert.pem --cert src/main/resources/certificates/SAN/DTG/client/SAN.cert.pem --key src/main/resources/certificates/SAN/DTG/client/SAN.PKCS8.key.pem -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supiOrSuci":"imsi-240820000210000","servingNetworkName":"5G:mnc222.mcc111.3gppnetwork.org"}' 'https://selipc00015-vnf13-ausfvip.seli.gic.ericsson.se:443/nausf-auth/v1/ue-authentications'
 
Scenario: Authentication Initiation Request
  Given target type is AUSF_HTTP
  Given path is /nausf-auth/v1/ue-authentications
  Given action name is POST-authentication-5G-aka
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
  "supiOrSuci":"imsi-<imsi>",
  "servingNetworkName":"5G:mnc222.mcc111.3gppnetwork.org"
  }
  """
  When we send POST request
  Then we expect response status code 201
  Then we expect response time less than 2000 milliseconds
  Then we expect response content text property authType equals 5G_AKA
  Then compute resStar using 5G-AKA algorithm
  Then extract path from URI in response content property _links.5g-aka.href and save as authCtxId
