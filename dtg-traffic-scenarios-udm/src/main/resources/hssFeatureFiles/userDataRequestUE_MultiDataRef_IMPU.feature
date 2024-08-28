Feature: User Data Request Capability IMPU

Scenario: User Data Request Capability IMPU
  Given Diameter target type is IMS
  Given Diameter application is Sh
  Given Diameter request name is User-Data-Request
  Given action name is User-Data-Capability-Impu
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
            { "name":"Public-Identity", "value":"sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org"}
        ]
    },
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"Data-Reference", "value":<data_ref>}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

