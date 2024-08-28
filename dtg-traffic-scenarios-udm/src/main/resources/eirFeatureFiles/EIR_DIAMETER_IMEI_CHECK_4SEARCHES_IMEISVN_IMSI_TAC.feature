Feature: Diameter Check Imei

Scenario: ME Identity-Check IMEISV + IMSI + TAC (4 searches)
  Given Diameter target type is EIR
  Given Diameter application is S13
  Given Diameter request name is ME-Identity-Check-Request
  Given Diameter request AVPs are:
  """
  [
    { "name":"Session-Id", "value":"session.001:<imei>" },
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777252 }
        ]
    },
    { "name":"Auth-Session-State", "value": "NO_STATE_MAINTAINED" },
    { "name":"Origin-Host", "value":"mme.ericsson.se" },
    { "name":"Origin-Realm", "value":"ericsson.se" },
    { "name":"Destination-Realm", "value":"ericsson.se" },
    { "name":"Terminal-Information", "avps":[
        { "name":"IMEI", "value":"<imei>" },
    { "name":"Software-Version", "value":"<svn>" }
    ]
    },
    { "name":"User-Name", "value":"<imsi>"}
  ]
  """

  When we send Diameter request
  Then we expect Diameter result DIAMETER_SUCCESS
  Then we expect Diameter response time less than 2000 milliseconds
  Then we expect Diameter answer contains AVPs:
  """
  [
    { "name":"Equipment-Status", "value": <status> }
  ]
  """
