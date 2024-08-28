Feature: Server Assignment Registration P-CSCF Restoration 4G Request

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
      { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST>" },
      { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM>" },
      { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777251 }
        ]
      },
      { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-ID", "value":1 },
            { "name":"Feature-List", "value":7 }
        ]
      },
      { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-ID", "value":2 },
            { "name":"Feature-List", "value":65536 }
        ]
      },
      { "name":"Result-Code", "value":2001 }
    ]
  """


Scenario: Server Assignment Registration Pcscf Restoration
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
    { "name":"Server-Assignment-Type", "value":<sa_type>},
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

Scenario: wait for incoming Insert-Subscriber-Data-Request from HSS
  Then we wait for Diameter Insert-Subscriber-Data-Request for 30 seconds

