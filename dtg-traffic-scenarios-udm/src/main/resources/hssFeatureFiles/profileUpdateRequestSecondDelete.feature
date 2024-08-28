Feature: Profile Update Request

Scenario: Profile Update Request
  Given Diameter target type is IMS
  Given Diameter application is Sh
  Given Diameter request name is Profile-Update-Request
  Given action name is Profile-Update-Delete
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
    { "name":"Auth-Session-State", "value":1},
    { "name":"User-Identity", "avps":[
            { "name":"Public-Identity", "value":"sip:UserName<mscid>_0PublicID0@ericsson.se"}
        ]
    },
    { "name":"User-Data_Sh", "value":"<?xml version=\"1.0\" encoding=\"UTF-8\" ?><Sh-Data><RepositoryData><ServiceIndication>ServiceId1</ServiceIndication><SequenceNumber>2</SequenceNumber></RepositoryData></Sh-Data>"},
    { "name":"Data-Reference", "value":0}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

