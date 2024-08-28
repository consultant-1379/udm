Feature: Profile Update Request with Notification with Alias Group ID

Scenario: prepare default answer for incoming Push-Notification-Request
  Given Incoming Diameter Push-Notification-Request target type is IMS
  Given Incoming Diameter Push-Notification-Request application is Sh
  When we receive default incoming Diameter Push-Notification-Request no key
  Then save Incoming Diameter Push-Notification-Request AVP Session-Id value as sessionId
  Then we send Diameter answer for Push-Notification-Request with AVPs:
  """
    [
      { "name":"Session-Id", "value":"<sessionId>" },
      { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
            { "name":"Auth-Application-Id", "value":16777217}
        ]
      },
      { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(2)>" },
      { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(2)>" },
      { "name":"Result-Code", "value":2001 },
      { "name":"Auth-Session-State", "value":1 }
    ]
  """
  ##Then we delay Diameter answer for 200 ms

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
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(3)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(3)>"},
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST(3)>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM(3)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"User-Identity", "avps":[
            { "name":"Public-Identity", "value":"sip:UserName<mscid>_0PublicID0@ericsson.se"}
        ]
    },
    { "name":"User-Data_Sh", "value":"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Sh-Data><RepositoryData><ServiceIndication>ServiceId1</ServiceIndication><SequenceNumber><SeqNumValue></SequenceNumber><ServiceData>Service Data corresponding to ebfjejlldeneidjqcdcoekllaiecboghiphkekpmbvlnkilrcbchinolopnehfplbmdeplzaalzjldfxingfcfanofoczddcjegnarlhlhrkcnpzhmjodrqfoebgnhkbmpzhnaeinnhdkmmlfpnennbbfmxfolmhdcjjbmbgkjnjjhdfkjaghagddlbbdjiobcjj</ServiceData></RepositoryData></Sh-Data>"},
    { "name":"Data-Reference", "value":0}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds


