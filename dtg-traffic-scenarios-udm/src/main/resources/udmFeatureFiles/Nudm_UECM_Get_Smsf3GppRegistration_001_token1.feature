Feature: Get Smsf3GppRegistration

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"smsfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "plmnId": {"mcc": "111", "mnc": "222"}}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/smsf-3gpp-access';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:32657/nudm-sdm/v2/imsi-240810000000000/registrations/smsf-3gpp-access'

#No other Scenarios execution dependencies

Scenario: Send Get Smsf3GppRegistration
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-uecm/v1/imsi-<imsi>/registrations/smsf-3gpp-access
  Given request header is Authorization:Bearer <token_uecm>
  Given request header is Content-Type:application/json
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
