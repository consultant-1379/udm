Feature: Server Assignment Deregistration Request

Scenario: Server Assignment Deregistration Request
  Given Diameter target type is IMS
  Given Diameter application is Cx
  Given Diameter request name is Server-Assignment-Request
  Given action name is Server-Assignment-Deregistration
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
    { "name":"Auth-Session-State", "value":1},
    { "name":"Public-Identity", "value":"sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"Server-Name", "value":"<IMS_CLIENT_ORIGIN_HOST>"},
    { "name":"Server-Assignment-Type", "value":5},
    { "name":"User-Data-Already-Available", "value":0},
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

