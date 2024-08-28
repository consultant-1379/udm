Feature:  EIR SOC data population

Scenario: Populate SOC
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:ou=searchorder,serv=equipmentcheck,ou=servCommonData
  Given request content is
  """
  [
    {
      "dn": "ei=searchorderData,imsiPr=-1,ou=searchorder,serv=equipmentcheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
      "ldapAttributes": [
        {"name": "imsiPr", "values": [{"ldapAttributeValueS":"-1"}]},
        {"name": "unknownRsp", "values": [{"ldapAttributeValueS":"U"}]},
        {"name": "l1Num", "values": [{"ldapAttributeValueB":"AQ=="}]},
        {"name": "rsp1", "values": [{"ldapAttributeValueS":"B"}]},
        {"name": "l2Num", "values": [{"ldapAttributeValueB":"AA=="}]},
        {"name": "rsp2", "values": [{"ldapAttributeValueS":"W"}]},
        {"name": "l3Num", "values": [{"ldapAttributeValueB":"Ag=="}]},
        {"name": "rsp3", "values": [{"ldapAttributeValueS":"G"}]},
  	    {"name": "l4Num", "values": [{"ldapAttributeValueB":"BA=="}]},
        {"name": "rsp4", "values": [{"ldapAttributeValueS":"B"}]},
        {
          "name": "objectClass",
          "values": [
            {"ldapAttributeValueS":"top"},
            {"ldapAttributeValueS":"EI5"},
            {"ldapAttributeValueS":"CUDBExtensibleObject"}
          ]
        },
        {"name": "ei", "values": [{"ldapAttributeValueS":"searchorderData "}]}
      ]
    },
    {
      "dn": "ei=searchorderData,imsiPr=260000812,ou=searchorder,serv=equipmentcheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
      "ldapAttributes": [
        {"name": "imsiPr", "values": [{"ldapAttributeValueS":"260000812"}]},
        {"name": "unknownRsp", "values": [{"ldapAttributeValueS":"U"}]},
        {"name": "l1Num", "values": [{"ldapAttributeValueB":"BQ=="}]},
        {"name": "rsp1", "values": [{"ldapAttributeValueS":"W"}]},
        {"name": "l2Num", "values": [{"ldapAttributeValueB":"Bg=="}]},
        {"name": "rsp2", "values": [{"ldapAttributeValueS":"B"}]},
        {"name": "l3Num", "values": [{"ldapAttributeValueB":"Ag=="}]},
        {"name": "rsp3", "values": [{"ldapAttributeValueS":"G"}]},
        {"name": "l4Num", "values": [{"ldapAttributeValueB":"BA=="}]},
        {"name": "rsp4", "values": [{"ldapAttributeValueS":"B"}]},
        {
          "name": "objectClass",
          "values": [
            {"ldapAttributeValueS":"top"},
            {"ldapAttributeValueS":"EI5"},
            {"ldapAttributeValueS":"CUDBExtensibleObject"}
          ]
        },
        {"name": "ei", "values": [{"ldapAttributeValueS":"searchorderData "}]}
      ]
    }
  ]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
