Feature: Server Assignment Deregistration Request for SWx

Scenario: Server Assignment Deregistration Request
  Given Diameter target type is EPC
  Given Diameter application is SWx
  Given Diameter request name is Server-Assignment-Request
  Given action name is Server-Assignment-Deregistration
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"<imsi>"},
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
            { "name":"Auth-Application-Id", "value":16777265}
        ]
    },
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(3)>"},
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(3)>"},
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(3)>"},
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(3)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"User-Name", "value":"<imsi>"},
    { "name":"Server-Assignment-Type", "value":5}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

