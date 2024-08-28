Feature: Server Assignment Registration Request for Pdn GW SWx

Scenario: prepare for incoming Insert-Subscriber-Data-Request from HSS
  Given Incoming Diameter Insert-Subscriber-Data-Request target type is EPC
  Given Incoming Diameter Insert-Subscriber-Data-Request application is S6a
  Given Incoming Diameter Insert-Subscriber-Data-Request key AVP is User-Name
  When we receive incoming Diameter Insert-Subscriber-Data-Request for <imsi>
  Then save Incoming Diameter Insert-Subscriber-Data-Request AVP Session-Id value as sessionId
  Then we send Diameter answer for Insert-Subscriber-Data-Request with AVPs:
  """
    [
      { "name":"Session-Id", "value":"<sessionId>" },
      { "name":"Auth-Session-State", "value":1 },
      { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST>" },
      { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM>" },
      { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777251 }
        ]
      },
      { "name":"Result-Code", "value":2001 }
    ]
  """

Scenario: Server Assignment Registration Request
  Given Diameter target type is EPC
  Given Diameter application is SWx
  Given Diameter request name is Server-Assignment-Request
  Given action name is Server-Assignment-Registration
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
    { "name":"Visited-Network-Identifier", "value":"mnc012.mcc345.3gppnetwork.org"},
    { "name":"Service-Selection", "value":"apn15.com" },
    { "name":"MIP6-Agent-Info", "avps":[
            { "name":"MIP-Home-Agent-Address", "value":"150.<IP_2>.<IP_3>.<IP_4>" }
        ]
    },
    { "name":"Server-Assignment-Type", "value":13}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

Scenario: wait for incoming Insert-Subscriber-Data-Request from HSS
  Then we wait for Diameter Insert-Subscriber-Data-Request for 30 seconds

