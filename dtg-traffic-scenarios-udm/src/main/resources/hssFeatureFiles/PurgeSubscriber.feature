Feature: HSS-ESM-Purge-Subscriber

Scenario: Deregister user from 4G network
  Given Diameter target type is EPC
  Given Diameter application is S6a
  Given Diameter request name is Purge-UE-Request
  Given action name is Purge-UE-Request
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"session.<imsi>" },
    { "name":"Auth-Session-State", "value":1 },
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(1)>" },
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(1)>" },
    { "name":"Vendor-Specific-Application-Id", "avps":[
      { "name":"Vendor-Id", "value":10415 },
      { "name":"Auth-Application-Id", "value":16777251 }
    ]},
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(1)>" },
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(1)>" },
    { "name":"User-Name", "value":"<imsi>" }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds
