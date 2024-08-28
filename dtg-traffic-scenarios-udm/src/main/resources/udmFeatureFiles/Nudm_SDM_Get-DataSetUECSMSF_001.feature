Feature: Get SMSF Data

#curl --http2-prior-knowledge -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:30082/nudm-sdm/v2/imsi-240810000000000?dataset-names=UEC_SMSF'

#No other scenarios execution dependencies

Scenario: Send Get-SMSF-Data
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-sdm/v2/imsi-<imsi>?dataset-names=AM,UEC_SMSF
  Given request header is Content-Type:application/json
  Given action name is GET-UECSMSF-data-set
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
