#!/bin/bash


#IPv4 Ansible Example
#TG_VM_NAME="seliius26290.seli.gic.ericsson.se"



if [ {$1} == {"-h"} ]
then
  echo -e "\n #### SCRIPT USAGE####: "
  echo -e "\n $0 [-h] mTLS|clear|mTLS_6|clear_6 "
  exit
elif [ {$1} == {"mTLS"} ]
then
  echo -e "\n ### mTLS IPv4 DEPLOYMENT TYPE SELECTED####"
  mTLS="true"
  IPv6="false"
  sleep 2

elif [ {$1} == {"clear"} ]
then
  echo -e "\n ### http clear IPv4 DEPLOYMENT TYPE SELECTED####"
  mTLS="false"
  IPv6="false"
  sleep 2

elif [ {$1} == {"mTLS_6"} ]
then
  echo -e "\n ### mTLS IPv6 DEPLOYMENT TYPE SELECTED####"
  mTLS="true"
  IPv6="true"
  sleep 2

elif [ {$1} == {"clear_6"} ]
then
  echo -e "\n ### http clear IPv6 DEPLOYMENT TYPE SELECTED####"
  mTLS="false"
  IPv6="true"
  sleep 2

else
  echo -e "\n #### ERROR: NO VALID DEPLOYMENT TYPE PROVIDED.####"
  echo -e "\n ###PLEASE, CHECK HELP FOR MORE INFO: $0 -h ####"
  sleep 2
  exit
fi




if [ {$IPv6} == {"true"} ]
then
  TG_IP=$(host ${TG_VM_NAME} | awk '{print $5}')
else
  TG_IP=$(host ${TG_VM_NAME} | awk '{print $4}')
fi


AUSF_TRAFFIC_VIP=$(kubectl -n eric-ccsm get pods -l "istio=eric-ausf-traffic" -o jsonpath='{.items[0].status.hostIP}')
UDM_TRAFFIC_VIP=$(kubectl -n eric-ccsm get pods -l "istio=eric-udm-traffic" -o jsonpath='{.items[0].status.hostIP}')
EIR_TRAFFIC_VIP=$(kubectl -n eric-ccsm get pods -l "istio=eric-eir-traffic" -o jsonpath='{.items[0].status.hostIP}')
UDR_TRAFFIC_VIP=$(kubectl -n eric-ccsm get pods -l "istio=eric-udr-traffic" -o jsonpath='{.items[0].status.hostIP}')


if [ {$mTLS} == {"true"} ]
then
  AUSF_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-ausf-traffic -o jsonpath='{ .spec.ports[?(@.name=="https-mtls")].nodePort }')
  UDM_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-udm-traffic -o jsonpath='{ .spec.ports[?(@.name=="https-mtls")].nodePort }')
  UDM_HSS_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-udm-traffic -o jsonpath='{ .spec.ports[?(@.name=="http-clear")].nodePort }')
  EIR_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-eir-traffic -o jsonpath='{ .spec.ports[?(@.name=="https-mtls")].nodePort }')
  UDR_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-udr-traffic -o jsonpath='{ .spec.ports[?(@.name=="https-mtls")].nodePort }')
  UDR_TRAFFIC_PORT_FAILOVER="31391"
  UDR_TRAFFIC_PORT_FAILOVER2="31392"


elif [ {$mTLS} == {"false"} ]
then
  AUSF_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-ausf-traffic -o jsonpath='{ .spec.ports[?(@.name=="http2-clear")].nodePort }')
  UDM_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-udm-traffic -o jsonpath='{ .spec.ports[?(@.name=="http2-clear")].nodePort }')
  UDM_HSS_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-udm-traffic -o jsonpath='{ .spec.ports[?(@.name=="http-clear")].nodePort }')
  EIR_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-eir-traffic -o jsonpath='{ .spec.ports[?(@.name=="http2-clear")].nodePort }')
  UDR_TRAFFIC_PORT=$(kubectl -n eric-ccsm get svc eric-ingressgw-udr-traffic -o jsonpath='{ .spec.ports[?(@.name=="http2-clear")].nodePort }')
fi


AUSF_TRAFFIC_FQDN=$(nslookup "$AUSF_TRAFFIC_VIP" | awk -v ip="$AUSF_TRAFFIC_VIP" '/name/{print substr($NF,1,length($NF)-1)}')
UDM_TRAFFIC_FQDN=$(nslookup "$UDM_TRAFFIC_VIP" | awk -v ip="$UDM_TRAFFIC_VIP" '/name/{print substr($NF,1,length($NF)-1)}')
EIR_TRAFFIC_FQDN=$(nslookup "$EIR_TRAFFIC_VIP" | awk -v ip="$EIR_TRAFFIC_VIP" '/name/{print substr($NF,1,length($NF)-1)}')
UDR_TRAFFIC_FQDN=$(nslookup "$UDR_TRAFFIC_VIP" | awk -v ip="$UDR_TRAFFIC_VIP" '/name/{print substr($NF,1,length($NF)-1)}')



echo -e "\n VIPs, PORTS and FQDN to BE USED:"
echo -e "\n AUSF:"
echo $AUSF_TRAFFIC_VIP
echo $AUSF_TRAFFIC_PORT
echo $AUSF_TRAFFIC_FQDN

echo -e "\n UDM:"
echo $UDM_TRAFFIC_VIP
echo $UDM_TRAFFIC_PORT
echo $UDM_HSS_TRAFFIC_PORT
echo $UDM_TRAFFIC_FQDN

echo -e "\n EIR:"
echo $EIR_TRAFFIC_VIP
echo $EIR_TRAFFIC_PORT
echo $EIR_TRAFFIC_FQDN

echo -e "\n UDR:"
echo $UDR_TRAFFIC_VIP
echo $UDR_TRAFFIC_PORT
echo $UDR_TRAFFIC_FQDN
echo $UDR_TRAFFIC_PORT_FAILOVER
echo $UDR_TRAFFIC_PORT_FAILOVER2

sleep 4


echo -e "\n Removing .properties files in local folder:"
rm -fr *Server*.properties
rm -fr *Service*.properties
rm -fr ccsm_official_load.properties
rm -fr udr_provis_CCSM*properties
sleep 1

if test -f "./src/main/resources/ccsmPropertiesFiles/ccsm_official_load.properties"
then
  echo -e "\n Copying .properties files from src folder to local oner:"
  cp  ./src/main/resources/ccsmPropertiesFiles/*Server*.properties .
  cp  ./src/main/resources/ccsmPropertiesFiles/*Service*.properties .
  cp  ./src/main/resources/ccsmPropertiesFiles/ccsm_official_load.properties .
  cp  ./src/main/resources/ccsmPropertiesFiles/udr_provis_CCSM*properties .
  sleep 1
else
  echo -e "\n ERROR: No access to *properties file under ./src/main/resources/ccsmPropertiesFiles/"
  echo -e "\n Before running this script, you must copy src folder from nft repo to your dtg execution folder where this script is run"
  exit
fi

for file in `ls *Server*.properties` ; do echo -e "\n Updating TG_VM_NAME in file: ${file} "; sed -i "s|<TG_VM_NAME>|${TG_VM_NAME}|g" $file ;  done

if [ {$mTLS} == {"false"} ]
then
  for file in `ls *MF*Server*.properties` ; do echo -e "\n Updating SECURE flag in file: ${file} "; sed -i "s|SECURE = true|SECURE = false|g" $file ;  done
  for file in `ls *Service*.properties` ; do echo -e "\n Updating SECURE flag in file: ${file} "; sed -i "s|SECURE = TRUE|SECURE = false|g" $file ;  done
fi


echo -e "\n Updating HOST and PORT in UDRSim_Service.properties file"
sed -i "s|<UDR_TRAFFIC_PORT>|${UDR_TRAFFIC_PORT}|g" UDRSim_Service.properties
sed -i "s|<UDR_TRAFFIC_FQDN>|${UDR_TRAFFIC_FQDN}|g" UDRSim_Service.properties

echo -e "\n Updating HOST and PORT in UDRSim_Service_failover.properties file"
sed -i "s|<UDR_TRAFFIC_PORT>|${UDR_TRAFFIC_PORT_FAILOVER}|g" UDRSim_Service_failover.properties
sed -i "s|<UDR_TRAFFIC_FQDN>|${UDR_TRAFFIC_FQDN}|g" UDRSim_Service_failover.properties

echo -e "\n Updating HOST and PORT in UDRSim_Service_failover2.properties file"
sed -i "s|<UDR_TRAFFIC_PORT>|${UDR_TRAFFIC_PORT_FAILOVER2}|g" UDRSim_Service_failover2.properties
sed -i "s|<UDR_TRAFFIC_FQDN>|${UDR_TRAFFIC_FQDN}|g" UDRSim_Service_failover2.properties


echo -e "\n Updating HOST and PORT in AUSF_Service_2.properties file"
sed -i "s|<AUSF_TRAFFIC_PORT>|${AUSF_TRAFFIC_PORT}|g" AUSF_Service_2.properties
sed -i "s|<AUSF_TRAFFIC_FQDN>|${AUSF_TRAFFIC_FQDN}|g" AUSF_Service_2.properties

echo -e "\n Updating HOST and PORT in EIR_Service.properties file"
sed -i "s|<EIR_TRAFFIC_PORT>|${EIR_TRAFFIC_PORT}|g" EIR_Service.properties
sed -i "s|<EIR_TRAFFIC_FQDN>|${EIR_TRAFFIC_FQDN}|g" EIR_Service.properties

for file in `ls UDM_Service*.properties` 
do 
  echo -e "\n Updating HOST and PORT in ${file} file "
  sed -i "s|<UDM_HSS_TRAFFIC_PORT>|${UDM_HSS_TRAFFIC_PORT}|g" $file
  sed -i "s|<UDM_TRAFFIC_PORT>|${UDM_TRAFFIC_PORT}|g" $file
  sed -i "s|<UDM_TRAFFIC_FQDN>|${UDM_TRAFFIC_FQDN}|g" $file
  if [ {$IPv6} == {"true"} ]
  then
      sed -i "s|<UDM_TRAFFIC_VIP>|[${UDM_TRAFFIC_VIP}]|g" $file  
  else
      sed -i "s|<UDM_TRAFFIC_VIP>|${UDM_TRAFFIC_VIP}|g" $file
  fi
done
