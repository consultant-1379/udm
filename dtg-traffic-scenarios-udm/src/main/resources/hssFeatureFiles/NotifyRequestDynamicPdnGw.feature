Feature: HSS-ESM-NotifyRequestDynamicPdnGw

Scenario: Notify Request
  Given Diameter target type is EPC
  Given Diameter application is S6a
  Given Diameter request name is Notify-Request
  Given action name is Notify-Request
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
        ]
    },
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(1)>" },
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(1)>" },
    { "name":"User-Name", "value":"<imsi>" },
    { "name":"NOR-Flags", "value":1 },
    { "name":"Service-Selection", "value":"apn06gnnv01.ericsson.se" },
    { "name":"MIP6-Agent-Info", "avps":[
            { "name":"MIP-Home-Agent-Address", "value":"150.<IP_2>.<IP_3>.<IP_4>" }
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

