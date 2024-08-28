Feature: AMF 3GPP Access Registration AMF1 IRAT from LTE REL16(only for HSS failover testing)


Scenario: Default callback handler initialization 2
  Given action name is hss2-callback
  Given callback request to server number 3 type GENERIC_HTTP
  Given callback request path prefix /nhss-uecm/v1/deregister-sn
  When we receive callback request
  Then we send default response with header content-type:application/json and status code 204
	
