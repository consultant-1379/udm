Feature: Register-Smsf3GppAccess

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsfInstanceId": "", "plmnId": {"mcc": "", "mnc": ""}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smsf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsSubscribed": true}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/sms-data';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"smsfInstanceId": "2ec823fe-4a62-4617-aabf-55d14627a3dd","plmnId": {"mcc": "111", "mnc": "222"}, "smsfSetId": "A1B2C3", "smsfMAPAddress" : "491100002400001"}' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000100/registrations/smsf-3gpp-access'

#No other scenarios execution dependencies

Scenario: Default callback handler initialization
  Given callback request to server number 7 type GENERIC_HTTP
  Given callback request HTTP method POST
  Given callback request path prefix /nef01/callback/uri/callbackUri
  Given action name is EE-UE-Reachability-for-SMS-callback-SCP
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send Register-AmfNef1-Smsf3GppAccess
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/smsf-3gpp-access
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "smsfInstanceId": "2ec823fe-4a62-4617-aabf-55d14627a3dd",
    "plmnId": {"mcc": "111", "mnc": "222"},
    "smsfSetId": "A1B2C3",
    "smsfMAPAddress": "34123456789"
  }
  """
  When we send PUT request
  Then we expect response status code 200
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
