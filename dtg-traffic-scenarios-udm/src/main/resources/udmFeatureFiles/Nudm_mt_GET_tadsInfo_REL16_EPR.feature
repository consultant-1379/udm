Feature: Get CM_GET_TADS

#Provisioning script:
#for i in {00000..00099};do IMSI="imsi-2408100000"$i;curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfInstanceId": "1ec823fe-4a62-4617-aabf-55d14627a3dd", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "imsVoPS": "NON_HOMOGENEOUS_OR_UNKNOWN","guami": {"plmnId": {"mcc": "", "mnc": ""}, "amfId": ""}}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#FT:
#curl --http1.1 -k -i -m 1 -X GET -H'content-type:application/json' 'http://eric-udm-traffic.istio-system:82/nudm-mt/v1/imsi-2408100000?fields=tadsInfo'

Scenario: Default callback handler initialization
  Given callback request to server number 7 type AMF_HTTP
  Given callback request path prefix /namf-mt/v1/ue-contexts/
  Given callback request with before key imsi-
  Given callback request with after key ?info-class=TADS
  Given action name is amf-get-tads
  Then we wait for callback request

Scenario: Send Nudm-mt_CM_GET-TADS
  Given target type is UDM_HTTP
  Given target tag is HTTP_2
  Given path is /nudm-mt/v1/imsi-<imsi>?fields=tadsInfo
  Given request header is Content-Type:application/json
  Given action name is get-tadsInfo-http2
  When we send GET request
  Then we expect callback request
  Then we send callback response with status code 200 and header content-type:application/json and content
  """
  {
    "ratType":"NR"
  }
  """
  Then we expect response status code 200
  Then we expect response time less than 22000 milliseconds
