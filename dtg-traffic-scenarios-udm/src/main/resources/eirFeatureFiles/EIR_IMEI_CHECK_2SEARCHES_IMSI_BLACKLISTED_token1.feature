Feature: Check Imei

Scenario: IMEI0F + IMSI (2 Searches) Blacklisted
  Given target type is EIR5G_HTTP
  Given target tag is HTTP_2
  Given path is /n5g-eir-eic/v1/equipment-status?pei=imei-<imei>0&supi=imsi-<imsi>
  Given request header is Authorization:Bearer <token_eir>
  Given request header is Content-Type:application/json
  When we send GET request
  Then we expect response status code 200
  Then we expect response content text property status equals BLACKLISTED
  Then we expect response time less than 2000 milliseconds
