#  Scenario for script IMS-370. It sends a SOAP Notification (User Termination) to ISM-Cx
#  that will trigger the Registration-Termination-Request.
#  When receiving the RTR it sends the Answer with the DIAMETER_SUCCESS code (2001)
#

Feature: Update-EPC-User-EpsAaaRegState


# Incoming Registration-Termination-Request is expected
Scenario: prepare for incoming Registration-Termination-Request from HSS
  Given Incoming Diameter Registration-Termination-Request target type is EPC
  Given Incoming Diameter Registration-Termination-Request application is Swx
  Given Incoming Diameter Registration-Termination-Request key AVP is User-Name
  When we receive incoming Diameter Registration-Termination-Request for <imsi>
  Then save Incoming Diameter Registration-Termination-Request AVP Session-Id value as sessionId
  Then we send Diameter answer for Registration-Termination-Request with AVPs:
  """
    [
      { "name":"Session-Id", "value":"<sessionId>" },
      { "name":"Auth-Session-State", "value":1 },
      { "name":"Origin-Host", "value":"<EPC_CLIENT_ORIGIN_HOST(3)>" },
      { "name":"Origin-Realm", "value":"<EPC_CLIENT_ORIGIN_REALM(3)>" },
      { "name":"Vendor-Specific-Application-Id", "avps":[
            { "name":"Vendor-Id", "value":10415 },
            { "name":"Auth-Application-Id", "value":16777265 }
        ]
      },
      { "name":"Result-Code", "value":2001 }
    ]
  """

Scenario: Update-EPC-User-EpsAaaRegState
  Given SOAP target type is PG_SOAP
  Given action name is UpdateEPCProfile
  Given SOAP request service is /HssEsmUdcWS/services/NotificationService
  Given SOAP request action is /HssEsmUdcWS/services/NotificationService
  Given SOAP request property ${Properties#mscId} equals <mscidprefix><mscid>
  Given SOAP request property ${Properties#imsi} equals <imsi>
  Given SOAP request property ${Properties#aaa} equals <EPC_CLIENT_ORIGIN_HOST(3)>
  Given SOAP request property ${Properties#realm} equals <EPC_CLIENT_ORIGIN_REALM(3)>
  Given SOAP request envelope is:
  """
    <soap:Envelope
        xmlns:trig="http://www.apertio.com/pgw/trigger"
        xmlns:typ="http://schemas.ericsson.com/udc/1.0/types/"
        xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
        <soap:Body>
            <typ:notify>
                <notificationEvent>provisioningEvent</notificationEvent>
                <additionalInformation typ:dN="serv=Identities,mscId=${Properties#mscId},ou=multiSCs,dc=operator,dc=com">
                        <ldapAttribute typ:binary="false" typ:ldapAttributeName="IMSI">
                                <ldapAttributeValue>${Properties#imsi}</ldapAttributeValue>
                        </ldapAttribute>
                </additionalInformation>
                <additionalInformation typ:dN="EpsDynInfId=EpsDynInf,EpsStaInfId=EpsStaInf,serv=EPS,mscId=${Properties#mscId},ou=multiSCs,dc=operator,dc=com">
                    <ldapAttribute typ:binary="false" typ:ldapAttributeName="EpsAaaAddr">
                        <ldapAttributeValue>${Properties#aaa}</ldapAttributeValue>
                    </ldapAttribute>
                    <ldapAttribute typ:binary="false" typ:ldapAttributeName="EpsAaaRealm">
                        <ldapAttributeValue>${Properties#realm}</ldapAttributeValue>
                    </ldapAttribute>
                </additionalInformation>
                <modificationInformation typ:dN="EpsDynInfId=EpsDynInf,EpsStaInfId=EpsStaInf,serv=EPS,mscId=${Properties#mscId},ou=multiSCs,dc=operator,dc=com" typ:operation="modify">
                    <affectedLdapAttribute typ:binary="false" typ:ldapAttributeName="EpsAaaRegState" typ:modification="replace">
                        <oldLdapAttributeValue>2</oldLdapAttributeValue>
                        <newLdapAttributeValue>0</newLdapAttributeValue>
                    </affectedLdapAttribute>
                </modificationInformation>
            </typ:notify>
        </soap:Body>
    </soap:Envelope>
  """
  When we send SOAP request
  Then we expect SOAP response has no fault
  Then we expect SOAP response time less than 60000 milliseconds

Scenario: wait for incoming Registration-Termination-Request from HSS
  Then we wait for Diameter Registration-Termination-Request for 30 seconds
