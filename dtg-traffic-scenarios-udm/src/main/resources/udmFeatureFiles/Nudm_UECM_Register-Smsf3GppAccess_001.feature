Feature: Register-Smsf3GppAccess

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsfInstanceId": "", "plmnId": {"mcc": "", "mnc": ""}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smsf-3gpp-access';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsSubscribed": true}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/111222/provisioned-data/sms-data';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"smsfInstanceId": "b20af4ca-72f5-4d53-8af4-f088bf28a901", "plmnId": {"mcc": "111", "mnc": "222"}}' 'http://localhost:30096/nudm-uecm/v1/imsi-240810000000100/registrations/smsf-3gpp-access'

#No other scenarios execution dependencies

Scenario: Send Register-Smsf3GppAccess
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/smsf-3gpp-access
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "smsfInstanceId": "b20af4ca-72f5-4d53-8af4-f088bf28a901",
    "plmnId": {"mcc": "111", "mnc": "222"}
  }
  """
  When we send PUT request
  Then we expect response status code 200
  Then we expect response status code 201
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds
