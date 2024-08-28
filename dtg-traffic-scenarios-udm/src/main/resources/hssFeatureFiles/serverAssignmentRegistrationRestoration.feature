Feature: Server Assignment Registration Request with Restoration Info

Scenario: Server Assignment Registration Request
  Given Diameter target type is IMS
  Given Diameter application is Cx
  Given Diameter request name is Server-Assignment-Request
  Given action name is Server-Assignment-Registration-Restoration
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
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-ID", "value":1 },
            { "name":"Feature-List", "value":5 }
        ]
    },
    { "name":"Multiple-Registration-Indication", "value":0},
    { "name":"SCSCF-Restoration-Info", "avps":[
            { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
            { "name":"SIP-Authentication-Scheme", "value":"NASS-Bundled" },
            { "name":"Restoration-Info", "avps":[
                    { "name":"Path", "value": "<sip:path1.server.com;lr>,<sip:path2.ser.com;lr>" },
                    { "name":"Contact", "value":"224f7a7a79204f73626f726e653a205468652073696e676572206f6620626c61636b207361626261746822203c7369703a7072696e63652d6f662d66616b6b696e2d6461726b6e65737340636f72706f726174696f6e5f6f665f6572696373736f6e2e636f6d3e3b713d302e373b20657870697265733d333630303030" },
                    { "name":"Subscription-Info", "avps":[
                            { "name":"Call-ID-SIP-Header", "value": "61383462346337366536363731303635386a626633647437" },
                            { "name":"From-SIP-Header", "value": "416c696365203c7369703a616c6963655f696e5f776f6e64" },
                            { "name":"To-SIP-Header", "value": "26f6220546865204275696c646572203c7369703a626f62" },
                            { "name":"Record-Route", "value": "3c7369703a736572766572312e6f7a7a792e636f6d3b6c72" },
                            { "name":"Contact", "value": "224f7a7a79204f73626f726e653a205468652073696e6765" }
                        ]
		    }
                ]
	    }
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

