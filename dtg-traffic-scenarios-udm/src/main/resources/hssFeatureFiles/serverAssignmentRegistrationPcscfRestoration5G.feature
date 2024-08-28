Feature: Server Assignment Registrationi P-CSCF Restoration UDM Request

Scenario: Default callback handler initialization
  Given action name is pcscfrestoration-callback-amf1-rel16_async
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /pcscfrestoration
  Given callback request with before key imsi-
  Given callback request with after key /
  When we receive callback request
  Then we send default response with status code 204


Scenario: Server Assignment Registration Pcscf Restoration UDM
  Given Diameter target type is IMS
  Given Diameter application is Cx
  Given Diameter request name is Server-Assignment-Request
  Given action name is Server-Assignment-Unregistered
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
    { "name":"Server-Assignment-Type", "value":3},
    { "name":"User-Data-Already-Available", "value":0},
    { "name":"SAR-Flags", "value":1},
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

