Feature: Routing Info Request for SLH

Scenario: Routing Info Request
  Given Diameter target type is EPC
  Given Diameter application is SLh
  Given Diameter request name is LCS-Routing-Info-Request
  Given action name is LCS-Routing-Info-Request
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"<imsi>"},
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
            { "name":"Auth-Application-Id", "value":16777291}
        ]
    },
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(4)>"},
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(4)>"},
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(4)>"},
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(4)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"MSISDN", "value":"<msisdn>"},
    { "name":"GMLC-Number", "value":"0x43065655f5"}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

