# http ANBC callback definition. Using AMF3 Server.
Feature: User Data Request tadsInfo 5G

Scenario: Default Callback Handler Initialization
    Given callback request to server number 3 type AMF_HTTP
    Given callback request path prefix /namf-mt/v1/
    Given callback request with before key imsi-
    Given callback request with after key ?info-class=TADS
    Given action name is amf-get-tads
    When we receive callback request
    Then we send default response with status code 200 and header content-type:application/json and content
  """
  {
    "ratType":"NR"
  }
  """


Scenario: User Data Request Nontransp tadsInfo 5G
  Given Diameter target type is IMS
  Given Diameter application is Sh
  Given Diameter request name is User-Data-Request
  Given action name is User-Data-Request-Tads
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
    { "name":"User-Name", "value":"<imsi>@ims.mnc280.mcc262.3gppnetwork.org"},
    { "name":"User-Identity", "avps":[
            { "name":"Public-Identity", "value":"tel:+<msisdn>"}
        ]
    },
    { "name":"Data-Reference", "value":26},
    { "name":"Requested-Domain", "value":0},
    { "name":"Current-Location", "value":1}
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 4000 milliseconds

