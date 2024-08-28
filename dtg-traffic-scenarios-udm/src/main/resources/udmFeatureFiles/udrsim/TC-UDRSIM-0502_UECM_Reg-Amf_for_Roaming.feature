Feature: UDM154-EE-SUPI-PEI-Change for Ind

Scenario: Send Register-Amf3GPPAccess With PEI

   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/context-data/amf-3gpp-access
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"guami": {"plmnId": {"mcc": "111", "mnc": "222"}, "amfId": "A1B2C3"},
    "amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd",
    "initialRegistrationInd": true,
    "deregCallbackUri": "<AMF_SERVER_SCHEME(2)>://<AMF_SERVER_ADDRESS(2)>:<AMF_SERVER_PORT(2)>/deregistration/imsi-<imsi>/",
    "ratType" : "NR"
   }
   """

   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
