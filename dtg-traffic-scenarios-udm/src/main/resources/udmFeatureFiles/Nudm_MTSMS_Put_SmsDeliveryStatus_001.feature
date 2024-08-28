Feature: Report delivery status for SM with Success report

#Provisioning script:
#for i in {00000..00100};do IMSI="imsi-2408100000"$i;MSISDN="msisdn-8608100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"supi": "'$IMSI'", "gpsi": "'$MSISDN'"}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$MSISDN'/id-translation-result';done

#for i in {00000..00100};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"scAddressList": []}' 'http://localhost:30098/nudr-dr/v1/subscription-data/'$IMSI'/context-data/sms-waiting';done

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X PUT -H'content-type:application/json' -d'{"scAddress": "01", "smsDeliveryOutcome": "SUCCESSFUL_TRANSFER"}' 'http://localhost:30096/nudm-mtsms/v1/msisdn-860810000000000/delivery-status'

#No other scenarios execution dependencies

Scenario: Send Put_SmsDeliveryStatus
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-mtsms/v1/msisdn-<msisdn>/delivery-status
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "scAddress": "01",
    "smsDeliveryOutcome": "SUCCESSFUL_TRANSFER"
  }
  """
  When we send PUT request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
