Feature: Profile Update Request STN SR IMPU

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
      { "name":"Result-Code", "value":2001 }
    ]
  """

Scenario: Profile Update Request 
  Given Diameter target type is IMS
  Given Diameter application is Sh
  Given Diameter request name is Profile-Update-Request
  Given action name is Profile-Update
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
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(2)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(2)>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM(2)>"},
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST(2)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"User-Identity", "avps":[
            { "name":"Public-Identity", "value":"sip:UserName<mscid>_0PublicID0@ericsson.se"}
        ]
    },
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"User-Data_Sh", "value":"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Sh-Data><Sh-IMS-Data><Extension><Extension><Extension><Extension><STN-SR><StnSrValue></STN-SR></Extension></Extension></Extension></Extension></Sh-IMS-Data></Sh-Data>"},
    { "name":"Data-Reference", "value":27}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

Scenario: wait for incoming Insert-Subscriber-Data-Request from HSS
  Then we wait for Diameter Insert-Subscriber-Data-Request for 2 seconds



