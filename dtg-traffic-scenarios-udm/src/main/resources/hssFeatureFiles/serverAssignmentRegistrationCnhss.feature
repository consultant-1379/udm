Feature: Server Assignment Registration Request

Scenario: Server Assignment Registration Request
  Given Diameter target type is IMS
  Given Diameter application is Cx
  Given Diameter request name is Server-Assignment-Request
  Given action name is Server-Assignment-Registration
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
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(1)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(1)>"},
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST(1)>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM(1)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"Public-Identity", "value":"sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"Server-Name", "value":"<IMS_CLIENT_ORIGIN_HOST(1)>"},
    { "name":"Server-Assignment-Type", "value":<sa_type>},
    { "name":"User-Data-Already-Available", "value":1},
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-ID", "value":1 },
            { "name":"Feature-List", "value":5 }
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

