Feature: cnHSS-4G-5G-IRAT

Scenario: Authentication Info Request
  Given Diameter target type is EPC
  Given Diameter application is S6a
  Given Diameter request name is Authentication-Information-Request
  Given action name is Authentication-Information-Request
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"session.<imsi>" },
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777251 }
        ]
    },
    { "name":"Auth-Session-State", "value":1 },
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(1)>" },
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(1)>" },
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(1)>" },
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(1)>" },
    { "name":"User-Name", "value":"<imsi>" },
    { "name":"Visited-PLMN-ID", "value":"0x620282" },
    { "name":"Requested-EUTRAN-Authentication-Info", "avps":[
            { "name":"Number-Of-Requested-Vectors", "value":2 },
            { "name":"Immediate-Response-Preferred", "value":1 }
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 2000 milliseconds

Scenario: Update Location Request
  Given Diameter target type is EPC
  Given Diameter application is S6a
  Given Diameter request name is Update-Location-Request
  Given action name is Update-Location-Request
  Given Diameter request is proxyable
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"session.<imsi>" },
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777251 }
        ]
    },
    { "name":"Auth-Session-State", "value":1 },
    { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(1)>" },
    { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(1)>" },
    { "name":"Destination-Host", "value":"<EPC_CLIENT_DESTINATION_HOST(1)>" },
    { "name":"Destination-Realm", "value":"<EPC_CLIENT_DESTINATION_REALM(1)>" },
    { "name":"User-Name", "value":"<imsi>" },
    { "name":"RAT-Type", "value":1004 },
    { "name":"ULR-Flags", "value":34 },
    { "name":"Visited-PLMN-ID", "value":"0x620282" },
    { "name":"Terminal-Information", "avps":[
            { "name":"IMEI", "value":"10001000275195" },
            { "name":"Software-Version", "value":"11" }
        ]
    }
  ]
  """
  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 2000 milliseconds

Scenario: prepare for incoming Cancel-Location-Request from HSS
  Given Incoming Diameter Cancel-Location-Request target type is EPC
  Given Incoming Diameter Cancel-Location-Request application is S6a
  Given Incoming Diameter Cancel-Location-Request key AVP is User-Name
  When we receive incoming Diameter Cancel-Location-Request for <imsi>
  Then we send Diameter answer for Cancel-Location-Request with AVPs:
  """
    [
      { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST>" },
      { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM>" },
      { "name":"Result-Code", "value":2001 }
    ]
  """

Scenario: Send Deregister-SN
  Given target type is UDM_HTTP
  Given path is /nhss-uecm/v1/deregister-sn
  Given request header is Content-Type:application/json
  Given request content is
  """
  {
    "imsi" : "<imsi>",
    "deregReason" : "EPS_TO_5GS_MOBILITY"
  }
  """
  When we send POST request
  Then we expect response status code 204
  Then we expect response time less than 2000 milliseconds


Scenario: wait for incoming Cancel-Location-Request from HSS
  Then we wait for Diameter Cancel-Location-Request for 30 seconds
