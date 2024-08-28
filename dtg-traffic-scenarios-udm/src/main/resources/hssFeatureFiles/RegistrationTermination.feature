#  Scenario for script IMS-290. It sends a SOAP Notification (User Termination) to ISM-Cx
#  that will trigger the Registration-Termination-Request.
#  When receiving the RTR it sends the Answer with the DIAMETER_SUCCESS code (2001)
#
Feature: Registration Termination Request

Scenario: prepare for incoming Registration-Termination-Request from HSS
  Given Incoming Diameter Registration-Termination-Request target type is IMS
  Given Incoming Diameter Registration-Termination-Request application is Cx
  Given Incoming Diameter Registration-Termination-Request key AVP is User-Name
  When we receive incoming Diameter Registration-Termination-Request for UserName<mscid>_0@ericsson.se
  ##  When we receive incoming Diameter Registration-Termination-Request for <imsi>
  Then save Incoming Diameter Registration-Termination-Request AVP Session-Id value as sessionId
  Then we send Diameter answer for Registration-Termination-Request with AVPs:
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
    { "name":"Auth-Session-State", "value":1},
    { "name":"Result-Code", "value":2001 }
  ]
  """


Scenario: Send SOAP-Notification-User-Termination-IMS
  Given target type is UDM_HTTP
  Given target tag is IMS_HTTP_1_1
  Given path is /HssIsmSdaUdcWS/services/NotificationService
  Given action name is SOAP-Notification-User-Termination-IMS
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
  <ldapAttribute typ:binary="false" typ:ldapAttributeName="ImsOrigScscf">
  <ldapAttributeValue>sip:<IMS_CLIENT_ORIGIN_HOST(1)></ldapAttributeValue>
  </ldapAttribute>
  </additionalInformation>
  <additionalInformation typ:dN="ImsShDynInfId=ImsShDynInf,IMPU=sip:UserName<mscid>_0PublicID0@ericsson.se,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
  <ldapAttribute typ:binary="true" typ:ldapAttributeName="ImsShData">
  <ldapAttributeValue>ACVFX10AX14An2QSMjAwOTAxMDNUMTgyMzEyMzQ1n2USMjAwOTAxMDNUMTgyMzEyMzQ1n0YSMjAwOTAxMDNUMTgyMzEyMzQ1</ldapAttributeValue>
  </ldapAttribute>
  </additionalInformation>
  <additionalInformation typ:dN="ImsShDynInfId=ImsShDynInf,IMPU=tel:+<msisdn>,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
  <ldapAttribute typ:binary="true" typ:ldapAttributeName="ImsShData">
  <ldapAttributeValue>ACVFX10AX14An2QSMjAwOTAxMDNUMTgyMzEyMzQ1n2USMjAwOTAxMDNUMTgyMzEyMzQ1n0YSMjAwOTAxMDNUMTgyMzEyMzQ1</ldapAttributeValue>
  </ldapAttribute>
  </additionalInformation>
  <additionalInformation typ:dN="ImsShDynInfId=ImsShDynInf,IMPU=sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
  <ldapAttribute typ:binary="true" typ:ldapAttributeName="ImsShData">
  <ldapAttributeValue>ACVFX10AX14An2QSMjAwOTAxMDNUMTgyMzEyMzQ1n2USMjAwOTAxMDNUMTgyMzEyMzQ1n0YSMjAwOTAxMDNUMTgyMzEyMzQ1</ldapAttributeValue>
  </ldapAttribute>
  </additionalInformation>
  <additionalInformation typ:dN="ImsShDynInfId=ImsShDynInf,IMPU=sip:<imsi>@ics.mnc280.mcc262.3gppnetwork.org,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
  <ldapAttribute typ:binary="true" typ:ldapAttributeName="ImsShData">
  <ldapAttributeValue>ACVFX10AX14An2QSMjAwOTAxMDNUMTgyMzEyMzQ1n2USMjAwOTAxMDNUMTgyMzEyMzQ1n0YSMjAwOTAxMDNUMTgyMzEyMzQ1</ldapAttributeValue>
  </ldapAttribute>
  </additionalInformation>
  <modificationInformation typ:operation="modify" typ:dN="ImsCxDynInfId=ImsCxDynInf,ImsSubsId=ImsSubs,serv=IMS,assocId=<mscid>,ou=Associations,dc=operator,dc=com">
  <affectedLdapAttribute typ:binary="false" typ:ldapAttributeName="ImsImpiImpuState" typ:modification="replace">
  <oldLdapAttributeValue>UserName<mscid>_0@ericsson.se$sip:UserName<mscid>_0PublicID0@ericsson.se$R</oldLdapAttributeValue>
  <oldLdapAttributeValue>UserName<mscid>_0@ericsson.se$tel:+<msisdn>$R</oldLdapAttributeValue>
  <oldLdapAttributeValue>UserName<mscid>_0@ericsson.se$sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org$R</oldLdapAttributeValue>
  <oldLdapAttributeValue>UserName<mscid>_0@ericsson.se$sip:<imsi>@ics.mnc280.mcc262.3gppnetwork.org$R</oldLdapAttributeValue>
  <newLdapAttributeValue>UserName<mscid>_0@ericsson.se$sip:UserName<mscid>_0PublicID0@ericsson.se$N</newLdapAttributeValue>
  <newLdapAttributeValue>UserName<mscid>_0@ericsson.se$tel:+<msisdn>$N</newLdapAttributeValue>
  <newLdapAttributeValue>UserName<mscid>_0@ericsson.se$sip:<imsi>@ims.mnc280.mcc262.3gppnetwork.org$N</newLdapAttributeValue>
  <newLdapAttributeValue>UserName<mscid>_0@ericsson.se$sip:<imsi>@ics.mnc280.mcc262.3gppnetwork.org$N</newLdapAttributeValue>
  </affectedLdapAttribute>
  </modificationInformation>
  </typ:notify>
  </soap:Body>
  </soap:Envelope>
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 11000 milliseconds


Scenario: wait for incoming Registration-Termination-Request from HSS
  Then we wait for Diameter Registration-Termination-Request for 11 seconds


