Feature: UDM154-EE-SUPI-PEI-Change for Ind

Scenario: Send Register-Amf3GPPAccess With PEI

   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
   "deregCallbackUri": "<AMF_SERVER_SCHEME>://<AMF_SERVER_ADDRESS>:<AMF_SERVER_PORT>/deregistration/imsi-<imsi>/",
   "guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
   "ratType": "NR",
   "initialRegistrationInd": true,
   "pei": "imei-88888888<imei>"
   }
   """

   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
