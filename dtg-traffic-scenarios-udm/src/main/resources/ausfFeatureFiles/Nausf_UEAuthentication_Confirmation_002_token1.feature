Feature: AMF authentication Confirmation with 5G-AKA
#This scenario should be run after Nausf_UEAuthentication_Initiation_Request_002.feature

#Provisioning script
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authType": "5G_AKA", "nfInstanceId": "instanceId", "success": true, "timeStamp": "2000-01-01 12:00:00"}' 'http://localhost:30082/nudr-dr/v1/subscription-data/imsi-240810000000001/auth-event'

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"resStar":{resStar}}' 'http://localhost:31384{authCtxId}'
#{authCtxId} and {resStar} are obtained from the response of authentication Initiation Request.Example:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"resStar":"C73159C78BA41008BD04D325C2EA3C60"}' 'http://localhost:31384/nausf-auth/v1/ue-authentications/cid-eric-ausf-engine-67767bbc76-cdxx5-20190307074737035719/5g-aka-confirmation'

Scenario: Authentication Confirmation
  Given target type is AUSF_HTTP
  Given path is <authCtxId>
  Given request header is Authorization:Bearer <token_ausf>
  Given request header is Content-Type:application/json
  Given action name is PUT-auth-confirmation5G-aka
  Given request content is
  """
  {
   "resStar":"<resStar>"
  }
  """
  When we send PUT request
  Then we expect response status code 200
  Then we expect response content text property authResult equals AUTHENTICATION_SUCCESS
  Then we expect response time less than 2000 milliseconds
