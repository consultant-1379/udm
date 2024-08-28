Feature:  UDR TAC data population

Scenario: Populate TAC for 3 searches
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:ei=imeiData,imeiSvn=352384020000000F,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData
  Given request content is
  """
  [{
    "dn": "ei=imeiData,imeiSvn=352384020000000F,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
    "ldapAttributes": [
      {"name": "imeiSvn", "values": [{"ldapAttributeValueS":"352384020000000F"}]},
      {"name": "date", "values": [{"ldapAttributeValueS":"20200601"}]},
      {"name": "time", "values": [{"ldapAttributeValueS":"110246"}]},
      {"name": "l0", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l1", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l2", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l3", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l4", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l5", "values": [{"ldapAttributeValueB":"AQ=="}]},
      {"name": "l6", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l7", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l8", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l9", "values": [{"ldapAttributeValueB":"AA=="}]},
      {
        "name": "objectClass",
        "values": [
          {"ldapAttributeValueS":"top"},
          {"ldapAttributeValueS":"EI6"},
          {"ldapAttributeValueS":"CUDBExtensibleObject"}
        ]
      },
      {"name": "ei", "values": [{"ldapAttributeValueS":"imeiData"}]}
    ]
  }]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds

Scenario: Populate TAC for 4 searches
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:ei=imeiData,imeiSvn=358692050000000F,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData
  Given request content is
  """
  [{
    "dn": "ei=imeiData,imeiSvn=358692050000000F,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
    "ldapAttributes": [
      {"name": "imeiSvn", "values": [{"ldapAttributeValueS":"358692050000000F"}]},
      {"name": "date", "values": [{"ldapAttributeValueS":"20200601"}]},
      {"name": "time", "values": [{"ldapAttributeValueS":"110246"}]},
      {"name": "l0", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l1", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l2", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l3", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l4", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l5", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l6", "values": [{"ldapAttributeValueB":"AQ=="}]},
      {"name": "l7", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l8", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l9", "values": [{"ldapAttributeValueB":"AA=="}]},
      {
        "name": "objectClass",
        "values": [
          {"ldapAttributeValueS":"top"},
          {"ldapAttributeValueS":"EI6"},
          {"ldapAttributeValueS":"CUDBExtensibleObject"}
        ]
      },
      {"name": "ei", "values": [{"ldapAttributeValueS":"imeiData"}]}
    ]
  }]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
