Feature: Multimedia Auth Request for SWx

Scenario: Multimedia Auth Request
  Given Diameter target type is EPC
  Given Diameter application is Swx
  Given Diameter request name is Multimedia-Auth-Request
  Given action name is Multimedia-Auth
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
    { "name":"Auth-Session-State", "value":1},
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(3)>"},
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(3)>"},
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(3)>"},
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(3)>"},
    { "name":"User-Name", "value":"<imsi>"},
    { "name":"SIP-Number-Auth-Items", "value":1},
    { "name":"SIP-Auth-Data-Item","avps":[
            { "name":"SIP-Authentication-Scheme", "value": "EAP-AKA"}
        ]
    },
    { "name":"RAT-Type", "value":2000 }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

