Feature: Get-SMS-MNG-Data

#Provisioning script
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"moSmsSubscribed": true, "mtSmsSubscribed": false}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/00000/provisioned-data/sms-mng-data';done

#FT
#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:32657/nudm-sdm/v2/imsi-240810000000000/sms-mng-data'

#No other Scenarios execution dependencies

Scenario: Send Get-SMS-MNG-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>/sms-mng-data
  Given request header is Authorization:Bearer <token_sdm>
  Given request header is Content-Type:application/json
  Given action name is GET-sms-mng-data
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
