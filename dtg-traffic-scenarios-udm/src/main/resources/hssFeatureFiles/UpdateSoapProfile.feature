Feature: Update-EPC-User-Profile

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
      { "name":"Result-Code", "value":2001 }
    ]
  """

Scenario: UpdateEPCProfile
  Given SOAP target type is PG_SOAP
  Given action name is UpdateEPCProfile
  Given SOAP request service is /HssEsmUdcWS/services/NotificationService
  Given SOAP request action is /HssEsmUdcWS/services/NotificationService
  Given SOAP request property ${Properties#mscId} equals <mscidprefix><mscid>
  Given SOAP request property ${Properties#imsi} equals <imsi>
  Given SOAP request property ${Properties#mme} equals <EPC_CLIENT_ORIGIN_HOST>
  Given SOAP request property ${Properties#realm} equals <EPC_CLIENT_ORIGIN_REALM>
  Given SOAP request envelope is:
  """
    <soap:Envelope
        xmlns:trig="http://www.apertio.com/pgw/trigger"
        xmlns:typ="http://schemas.ericsson.com/udc/1.0/types/"
        xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
            <typ:notify>
                <notificationEvent>provisioningEvent</notificationEvent>
                <additionalInformation typ:dN="serv=Identities,mscId=${Properties#mscId},ou=multiSCs,dc=o,dc=com">
					<ldapAttribute typ:binary="false" typ:ldapAttributeName="IMSI">
							<ldapAttributeValue>${Properties#imsi}</ldapAttributeValue>
					</ldapAttribute>
                </additionalInformation>
                <additionalInformation typ:dN="EpsDynInfId=EpsDynInf,EpsStaInfId=EpsStaInf,serv=EPS,mscId=${Properties#mscId},ou=multiSCs,dc=o,dc=com">
                    <ldapAttribute typ:binary="false" typ:ldapAttributeName="EpsMmeAddr">
                        <ldapAttributeValue>${Properties#mme}</ldapAttributeValue>
                    </ldapAttribute>
                    <ldapAttribute typ:binary="false" typ:ldapAttributeName="EpsMmeRealm">
                        <ldapAttributeValue>${Properties#realm}></ldapAttributeValue>
                    </ldapAttribute>
                </additionalInformation>
                <modificationInformation typ:dN="EpsStaInfId=EpsStaInf,serv=EPS,mscId=${Properties#mscId},ou=multiSCs,dc=o,dc=com" typ:operation="modify">
                    <affectedLdapAttribute typ:binary="false" typ:ldapAttributeName="EpsProfileId" typ:modification="replace">
                        <oldLdapAttributeValue>HSS-EsmProfile_Specific</oldLdapAttributeValue>
                        <newLdapAttributeValue>HSS-EsmProfile_Default</newLdapAttributeValue>
                    </affectedLdapAttribute>
                </modificationInformation>
            </typ:notify>
        </soap:Body>
    </soap:Envelope>
  """
  When we send SOAP request
  Then we expect SOAP response has no fault
  Then we expect SOAP response time less than 60000 milliseconds

Scenario: wait for incoming Insert-Subscriber-Data-Request from HSS
  Then we wait for Diameter Insert-Subscriber-Data-Request for 30 seconds
