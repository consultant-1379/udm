Feature: HSS-ESM-Update-Location


Scenario: Update Location Request
  Given Diameter target type is EPC
  Given Diameter application is S6a
  Given Diameter request name is Update-Location-Request
  Given action name is Update-Location-Request
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"session.<imsi>" },
    { "name":"Auth-Session-State", "value":1 },
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(1)>" },
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(1)>" },
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777251 }
        ]
    },
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(1)>" },
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(1)>" },
    { "name":"User-Name", "value":"<imsi>" },
    { "name":"Terminal-Information", "avps":[
            { "name":"IMEI", "value":"10001000275195" },
            { "name":"Software-Version", "value":"11" }
        ]
    },
    { "name":"ULR-Flags", "value":34 },
    { "name":"RAT-Type", "value":1004 },
    { "name":"Visited-PLMN-ID", "value":"0x620282" },
    { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-Id", "value":1 },
            { "name":"Feature-List", "value":134217735 }
        ]
    },
    { "name":"Homogeneous-Support-of-IMS-Voice-Over-PS-Sessions", "value":<voice_over_ps> }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds
