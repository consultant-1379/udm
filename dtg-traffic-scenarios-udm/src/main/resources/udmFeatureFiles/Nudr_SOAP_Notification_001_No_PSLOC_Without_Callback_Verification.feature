#This scenario does not need any provisioning since UDR is being simulated by DTG
#FT can not be implemented with a curl client, because it needs also a server
#This scenario does not verify the callback, so it will not fail in case callback is not received.

Feature: UDR Sends SOAP Notification to UDM

Scenario: Default callback handler initialization
  Given callback request to server number 1 type AMF_HTTP
  Given callback request path prefix /deregistration
  Given callback request with before key imsi-
  Given callback request with after key /
  Given action name is SOAP-deregistration-callback-amf1
  When we receive callback request
  Then we send default response with status code 204

Scenario: Send SOAP-Notification-Deregistration-AMF
  Given target type is UDM_HTTP
  Given target tag is HTTP_1_1_SEC
  Given path is /UdmUdrWs/services/NotificationServices
  Given action name is SOAP-Notification-Deregistration-AMF
  Given request header is Content-Type:text/xml; charset=utf-8
  Given request header is User-Agent: gSOAP/2.7
  Given request header is SOAPAction:"notify"
  Given request content is
  """
  {
  <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:ns2="http://schemas.ericsson.com/udc/1.0/types/">
  <SOAP-ENV:Body>
  <ns2:notify xmlns:ns2="http://schemas.ericsson.com/udc/1.0/types/">;
  <notificationEvent>PS Location Update</notificationEvent>
  <additionalInformation ns2:dN="serv=csps,mscId=222222222222222,ou=multiscs,dc=operator,dc=com">
  <ldapAttribute ns2:ldapAttributeName="IMSI">
  <ldapAttributeValue><imsi></ldapAttributeValue>
  </ldapAttribute>
  </additionalInformation>
  <modificationInformation ns2:operation="modify">
  <affectedLdapAttribute ns2:ldapAttributeName="PSLOC" ns2:modification="replace">
  <oldLdapAttributeValue>2</oldLdapAttributeValue>
  <newLdapAttributeValue>0</newLdapAttributeValue>
  </affectedLdapAttribute>
  </modificationInformation>
  </ns2:notify>
  </SOAP-ENV:Body>
  </SOAP-ENV:Envelope>
  }
  """
  When we send POST request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds
