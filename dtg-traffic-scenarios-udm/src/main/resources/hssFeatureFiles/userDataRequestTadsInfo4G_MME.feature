Feature: User Data Request tadsInfo 4G MME

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
      { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(1)>" },
      { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(1)>" },
      { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777251 }
        ]
      },
      { "name":"RAT-Type", "value":1004 },
      { "name":"IMS-Voice-Over-PS-Sessions-Supported", "value":1 },
      { "name":"Result-Code", "value":2001 }
    ]
  """

# UDR is sent to SDA_sh
Scenario: User Data Request Nontransp tadsInfo 4G MME
  Given Diameter target type is IMS
  Given Diameter application is Sh
  Given Diameter request name is User-Data-Request
  Given action name is User-Data-Request-Tads
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"<imsi>"},
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
	    { "name":"Auth-Application-Id", "value":16777217}
        ]
    },
    { "name":"Auth-Session-State", "value":1},
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(2)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(2)>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM(2)>"},
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST(2)>"},
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"User-Identity", "avps":[
           { "name":"Public-Identity", "value":"tel:+<msisdn>"}
        ]
    },
    { "name":"Data-Reference", "value":26},
    { "name":"Requested-Domain", "value":0},
    { "name":"Current-Location", "value":1}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 14000 milliseconds
  Then we expect Diameter response before action IDR_Verify

Scenario: wait for incoming Insert-Subscriber-Data-Request from HSS
  Then we wait for Diameter Insert-Subscriber-Data-Request for 11 seconds

Scenario: Delay
  Given action name is UDA_receiving
  Then Sleep for 1 seconds

Scenario: Any action
  Given action name is IDR_Verify
  Then Sleep for 1 seconds



