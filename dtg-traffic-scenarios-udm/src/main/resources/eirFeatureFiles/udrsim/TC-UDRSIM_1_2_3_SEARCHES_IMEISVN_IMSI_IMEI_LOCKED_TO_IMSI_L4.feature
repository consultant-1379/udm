Feature:  EIR data population for IMEISVN + IMSI (IMEI locked to IMSI) (1-3 Searches) Whitelisted
# This covers following scenario:
# - IMEI_CHECK_WHITELISTED_IMEISVN_IMSI_IMEI_LOCKED_TO_IMSI

Scenario: Populate IMEISVN data
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:ei=imeiData,imeiSvn=<imei><svn>,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData
  Given request content is
  """
  [{
    "dn": "ei=imeiData,imeiSvn=<imei><svn>,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
    "ldapAttributes": [
      {"name": "imeiSvn", "values": [{"ldapAttributeValueS":"<imei><svn>"}]},
      {"name": "date", "values": [{"ldapAttributeValueS":"20200601"}]},
      {"name": "time", "values": [{"ldapAttributeValueS":"110246"}]},
      {"name": "l0", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l1", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l2", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l3", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l4", "values": [{"ldapAttributeValueB":"AQ=="}]},
      {"name": "l5", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l6", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l7", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l8", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l9", "values": [{"ldapAttributeValueB":"AA=="}]},
      {
        "name": "objectClass",
        "values": [
          {"ldapAttributeValueS": "top"},
          {"ldapAttributeValueS": "EI6"},
          {"ldapAttributeValueS": "CUDBExtensibleObject"}
        ]
      },
      {"name": "ei", "values": [{"ldapAttributeValueS":"imeiData"}]}
    ]
  }]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds

Scenario: Populate IMEI0F data
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:ei=imeiData,imeiSvn=<imei>0F,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData
  Given request content is
  """
  [{
    "dn": "ei=imeiData,imeiSvn=<imei>0F,ou=IMEIdata,serv=equipmentCheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
    "ldapAttributes": [
      {"name": "imeiSvn", "values": [{"ldapAttributeValueS":"<imei>0F"}]},
      {"name": "date", "values": [{"ldapAttributeValueS":"20200601"}]},
      {"name": "time", "values": [{"ldapAttributeValueS":"110246"}]},
      {"name": "l0", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l1", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l2", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l3", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l4", "values": [{"ldapAttributeValueB":"AQ=="}]},
      {"name": "l5", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l6", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l7", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l8", "values": [{"ldapAttributeValueB":"AA=="}]},
      {"name": "l9", "values": [{"ldapAttributeValueB":"AA=="}]},
	    {"name": "lockedImsi", "values": [{"ldapAttributeValueS":"<imsi>"}]},
      {
        "name": "objectClass",
        "values": [
          {"ldapAttributeValueS": "top"},
          {"ldapAttributeValueS": "EI6"},
          {"ldapAttributeValueS": "CUDBExtensibleObject"}
        ]
      },
      {"name": "ei", "values": [{"ldapAttributeValueS":"imeiData"}]}
    ]
  }]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds

Scenario: Populate IMSI data
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:ei=imsiData,IMSI=<imsi>,ou=IMSIdata,serv=equipmentCheck,ou=servCommonData
  Given request content is
  """
  [{
    "dn": "ei=imsiData,IMSI=<imsi>,ou=IMSIdata,serv=equipmentCheck,ou=servCommonData,dc=cudb,dc=eir,dc=ericsson,dc=com",
    "ldapAttributes": [
      {"name": "IMSI", "values": [{"ldapAttributeValueS":"<imsi>"}]},
      {
        "name": "objectClass",
        "values": [
          {"ldapAttributeValueS": "top"},
          {"ldapAttributeValueS": "EI8"},
          {"ldapAttributeValueS": "CUDBExtensibleObject"}
        ]
      },
      {"name": "ei", "values": [{"ldapAttributeValueS":"imsiData"}]}
    ]
  }]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds

Scenario: Populate MSISDN data
  Given target type is UDR_HTTP
  Given path is /ncudr-gud-dr/v1/directory-data/query/load
  Given request header is Content-Type:application/json
  Given request header is x-eric-ldapinfoquery:serv=identities,IMSI=<imsi>,dc=imsi,ou=identities
  Given request content is
  """
  [{
    "dn": "serv=Identities,mscId=100000000000000000000<msisdn>,ou=multiSCs,dc=eir,dc=ericsson,dc=com",
    "ldapAttributes": [
      {"name": "IMSI", "values": [{"ldapAttributeValueS":"<imsi>"}]},
      {
        "name": "objectClass",
        "values": [
          {"ldapAttributeValueS": "CUDBService"},
          {"ldapAttributeValueS": "mscIdentities"}
        ]
      },
      {"name": "CDC", "values": [{"ldapAttributeValueS":"1"}]},
  	  {"name": "imsiMask", "values": [{"ldapAttributeValueS":"'0000000000010001'B"}]},
	    {"name": "MSISDN", "values": [{"ldapAttributeValueS":"<msisdn>"}]},
	    {"name": "msisdnMask", "values": [{"ldapAttributeValueS":"'0000000000000001'B"}]},
	    {"name": "serv", "values": [{"ldapAttributeValueS":"Identities"}]}
    ]
  }]
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
