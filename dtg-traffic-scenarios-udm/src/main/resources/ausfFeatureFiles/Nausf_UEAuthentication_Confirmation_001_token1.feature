Feature: AMF authentication Confirmation with EAP-AKA
#This scenario should be run after Nausf_UEAuthentication_Initiation_Request_001.feature

#Provisioning script
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"authType": "EAP_AKA_PRIME", "nfInstanceId": "instanceId", "success": true, "timeStamp": "2000-01-01 12:00:00"}' 'http://localhost:30082/nudr-dr/v1/subscription-data/imsi-240810000000001/auth-event'

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"eapPayload":{eapPayload}}' 'http://localhost:31384{authCtxId}'
#{eapPayload} is computed from the response of authentication Initiation Request with EAP-AKA-PRIME algorithm.
#{authCtxId} is obtained from the response of authentication Initiation Request.Example:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"eapPayload":"AgEALDIBAACHAQAAAwMAQHBXMWWeTuYOCwUAAFP6RSbggnOQUx5u1LAUO7U="}' 'http://localhost:31384/nausf-auth/v1/ue-authentications/cid-eric-ausf-engine-67767bbc76-cdxx5-20190308035818035730/eap-session'

Scenario: Authentication Confirmation
  Given target type is AUSF_HTTP
  Given path is <authCtxId>
  Given request header is Authorization:Bearer <token_ausf>
  Given request header is Content-Type:application/json
  Given action name is POST-auth-confirmation-eap-aka
  Given request content is
  """
  {
  "eapPayload":"<eapPayload>"
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response content text property authResult equals AUTHENTICATION_SUCCESS
  Then we expect response time less than 2000 milliseconds

