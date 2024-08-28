Feature: Get CM_GET_TADS
#This script is based in Nudm_voice_CM_GET_001.feature but using http2 so traffic is more stable for overload test.

#Provisioning script:
#for i in {00000..00099};do IMSI="imsi-2408100000"$i; curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"amfId": "AMFID ID 01", "deregCallbackUri": "http://amf01.ericsson.net/callback/uri/deregCallbackUri", "imsVoPS": "HOMOGENEOUS_SUPPORT"}' 'http://localhost:30082/nudr-dr/v1/subscription-data/'$IMSI'/context-data/amf-3gpp-access';done

#FT:
#curl -k -i -m 1 -X GET -H'content-type:application/json' 'http://localhost:30096/nudm-voice-uecm/v1/imsi-240810000000000/context-data?dataRef=TADS'

Scenario: Send Nudm-voice_CM_GET-TADS
  Given target type is UDM_HTTP
  Given target tag is HTTP_2_PLAIN
  Given path is /nudm-voice-uecm/v1/imsi-<imsi>/context-data?dataRef=TADS
  Given request header is Content-Type:application/json
  When we send GET request
  Then we expect response status code 200
  Then we expect response time less than 2000 milliseconds

