Feature: Multimedia Auth Request Resync for Zh

Scenario: Multimedia Auth Request Resync
  Given Diameter target type is IMS
  Given Diameter application is Zh
  Given Diameter request name is Multimedia-Auth-Request
  Given action name is Zh-Multimedia-Auth-Resync
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"<imsi>"},
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
            { "name":"Auth-Application-Id", "value":16777221}
        ]
    },
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(4)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(4)>"},
    { "name":"Destination-Host", "value":"<IMS_CLIENT_DESTINATION_HOST(4)>"},
    { "name":"Destination-Realm", "value":"<IMS_CLIENT_DESTINATION_REALM(4)>"},
    { "name":"Auth-Session-State", "value":1},
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"SIP-Auth-Data-Item","avps":[
            { "name":"SIP-Authentication-Scheme", "value": "Digest-AKAv1-MD5"},
            { "name":"SIP-Authorization", "value": "0x000000000000000000000000003b0b283bd703553b01437d08<SipAuthValue>"}
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

