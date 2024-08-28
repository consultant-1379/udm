Feature: User Authorization Request

Scenario: User Authorization Request
  Given Diameter target type is IMS
  Given Diameter application is Cx
  Given Diameter request name is User-Authorization-Request
  Given action name is User-Authorization
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"<imsi>"},
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
            { "name":"Auth-Application-Id", "value":16777216}
        ]
    },
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM>"},
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM>"},
    { "name":"User-Name", "value":"UserName<mscid>_0@ericsson.se"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"Public-Identity", "value":"sip:UserName<mscid>_0PublicID0@ericsson.se"},
    { "name":"Visited-Network-Identifier", "value":"p.cscf.visited.es"},
    { "name":"Access-Network-Information", "value":"adsl;network-provided;dsl-location=3"},
    { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-ID", "value":1 },
            { "name":"Feature-List", "value":5 }
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_FIRST_REGISTRATION
  Then we expect Diameter response time less than 4000 milliseconds

