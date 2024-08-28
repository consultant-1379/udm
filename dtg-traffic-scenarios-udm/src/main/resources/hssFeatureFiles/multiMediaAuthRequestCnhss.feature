Feature: Multimedia Auth Request

Scenario: Multimedia Auth Request
  Given Diameter target type is IMS
  Given Diameter application is Cx
  Given Diameter request name is Multimedia-Auth-Request
  Given action name is Multimedia-Auth
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
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST(1)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(1)>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM(1)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"Public-Identity", "value":"sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"SIP-Number-Auth-Items", "value":1},
    { "name":"SIP-Auth-Data-Item","avps":[
            { "name":"SIP-Authentication-Scheme", "value": "Digest-AKAv1-MD5"}
        ]
    },
    { "name":"Server-Name", "value":"<IMS_CLIENT_ORIGIN_HOST(1)>"}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

