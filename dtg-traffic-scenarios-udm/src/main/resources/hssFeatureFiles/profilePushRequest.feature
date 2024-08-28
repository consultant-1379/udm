Feature: Push Profile Request

Scenario: prepare for incoming Push-Profile-Request from HSS
  Given Incoming Diameter Push-Profile-Request target type is IMS
  Given Incoming Diameter Push-Profile-Request application is Cx
  Given Incoming Diameter Push-Profile-Request key AVP is User-Name
  When we receive incoming Diameter Push-Profile-Request for <imsi>@ims.mnc280.mcc262.3gppnetwork.org
  Then save Incoming Diameter Push-Profile-Request AVP Session-Id value as sessionId
  Then we send Diameter answer for Push-Profile-Request with AVPs:
  """
  [
    { "name":"Session-Id", "value":"<sessionId>"},
    { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415},
            { "name":"Auth-Application-Id", "value":16777216}
        ]
    },
    { "name":"Origin-Host", "value":"<IMS_CLIENT_ORIGIN_HOST(1)>"},
    { "name":"Origin-Realm", "value":"<IMS_CLIENT_ORIGIN_REALM(1)>"},
    { "name":"Result-Code", "value":2001 },
    { "name":"Auth-Session-State", "value":1},
    { "name":"Supported-Features", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Feature-List-ID", "value":1 },
            { "name":"Feature-List", "value":5 }
        ]
    }
  ]
  """

  Scenario: Send SOAP-Profile-Update-Location-IMS
  Given target type is UDM_HTTP
  Given target tag is IMS_HTTP_1_1
  Given path is /HssIsmSdaUdcWS/services/NotificationService
  Given action name is SOAP-Profile-Update-Location-IMS
  Given request header is Content-Type:text/xml
  Given request header is SOAPAction:"/HssIsmSdaUdcWS/services/NotificationService?wsdl"
  Given request header is Connection:Keep-Alive
  Given request content is
  """
   <?xml
        version="1.0"
        encoding="UTF-8"
        ?>
   <soap:Envelope
        xmlns:trig="http://www.apertio.com/pgw/trigger"
        xmlns:typ="http://schemas.ericsson.com/udc/1.0/types/"
        xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
	    <typ:notify>
                <notificationEvent>provisioningEvent</notificationEvent>
                <additionalInformation typ:dN="ImsCxDynInfId=ImsCxDynInf,ImsSubsId=ImsSubs,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
		<ldapAttribute typ:binary="false" typ:ldapAttributeName="ImsDiaServId">
		<ldapAttributeValue><IMS_CLIENT_ORIGIN_HOST(1)></ldapAttributeValue>
                </ldapAttribute>
                <ldapAttribute typ:binary="false" typ:ldapAttributeName="ImsDiaServRealm">
                <ldapAttributeValue><IMS_CLIENT_ORIGIN_REALM(1)></ldapAttributeValue>
                </ldapAttribute>
                <ldapAttribute typ:binary="true" typ:ldapAttributeName="ImsSubsDynFlags">
                <ldapAttributeValue>AGsMn4QBAJ+FAQGfhgEB</ldapAttributeValue>
                </ldapAttribute>
                <ldapAttribute typ:binary="false" typ:ldapAttributeName="ImsOrigScscf">
                <ldapAttributeValue>sip:<IMS_CLIENT_ORIGIN_HOST(1)></ldapAttributeValue>
                </ldapAttribute>
                </additionalInformation>
                <additionalInformation typ:dN="ImsShDynInfId=ImsShDynInf,IMPU=sip:UserName<mscid>_0PublicID0@ericsson.se,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
		<ldapAttribute typ:binary="true" typ:ldapAttributeName="ImsShData">
		<ldapAttributeValue>ACVFX10AX14An2QSMjAwOTAxMDNUMTgyMzEyMzQ1n2USMjAwOTAxMDNUMTgyMzEyMzQ1n0YSMjAwOTAxMDNUMTgyMzEyMzQ1</ldapAttributeValue>
                </ldapAttribute>
                </additionalInformation>
	        <modificationInformation typ:dN="ImsSubsId=ImsSubs,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com" typ:operation="modify">
                <affectedLdapAttribute typ:binary="false" typ:ldapAttributeName="ImsCharProfId" typ:modification="replace">
                <oldLdapAttributeValue>DefaultChargingProfile</oldLdapAttributeValue>
                <newLdapAttributeValue>NonDefaultChargingProfile</newLdapAttributeValue>
                </affectedLdapAttribute>
                </modificationInformation>
            </typ:notify>
        </soap:Body>
  </soap:Envelope>
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 4000 milliseconds


Scenario: wait for incoming Push-Profile-Request from HSS
  Then we wait for Diameter Push-Profile-Request for 6 seconds

