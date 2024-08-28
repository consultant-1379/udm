#!/bin/bash

DIR="DATA"

mkdir $DIR 
cd $DIR

echo "Save nodes info"
kubectl describe node | tee nodes_info.txt

echo "Save the deployment info"
kubectl describe deploy --all-namespaces | tee deploy_info.txt

echo "Save the pods information including the number of restarts to be compared in the post-execution phase"
kubectl get po --all-namespaces -o wide | sort --reverse --key 5 --numeric | tee pod_info.txt

echo "Save the services running"
kubectl get svc --all-namespaces | tee svc_info.txt

#echo "Save the events in the system"
#kubectl get events --sort-by='.metadata.creationTimestamp' --all-namespaces | tee events.txt

#echo "Save the number of PODs per node"
#for node in `kubectl get nodes -o wide | awk '{print $1}' | grep -v NAME`;do kubectl get po --all-namespaces -o wide | grep -i $node | wc -l;done | tee pre_numpod_node.txt

#echo "Save the total number of PODs"
#kubectl get po --all-namespaces -o wide | grep -v NAME | wc -l | tee pre_numpod.txt

#echo "Save the resources used by all nodes. Notice that there is not always an even distribution, especially if robustness TCs have been executed in the envioronment before"
#kubectl top nodes | tee pre_topnodes.txt

#echo "Save the replicaset information (useful specially before and after upgrades)"
#kubectl get rs -n eric-ccsm | tee pre_rs.txt

echo "Check that all pods are in status running (output should be empty)"
kubectl get pod --all-namespaces -o wide | awk '{print $4}' | grep -vE 'Running|Completed' | grep -v STATUS
sleep 3

echo "Check that all containers have beeen started. Output should be \"All containers are up\""
kubectl -n eric-ccsm get po | grep -v Completed | awk -F"[ /]+" 'BEGIN{found=0} !/NAME/ {if ($2!=$3) { found=1; print $0}} END { if (!found) print "All containers are up"}'
sleep 3

echo "Check that all nodes are in status Ready (output should be empty)"
kubectl get nodes | awk '{print $2}' | grep -v Ready | grep -v STATUS
sleep 3

echo "Save the starting time of the test to be used later on to collect the logs"
date -u +"%Y-%m-%dT%H:%M:%SZ" | tee pre_date.txt

echo "Save the kubectl version installed"
kubectl version | tee kubectl_version.txt

echo "Save the helm version installed"
helm version | tee helm_version.txt

echo "Save the software installed"
helm list | tee helm_list.txt

echo "Check if istio injector is set to true. If output of next command is empty, istio injector is set to true. Theoretically this should be the case, but doublecheck this statement"
for DEPLOY in `kubectl get deploy -n eric-ccsm | awk '{print $1}' | grep -vE 'cmagent|udr|NAME|ausf-st|eric-cm|eric-data|eric-fh|eric-odca|eric-pm'`;do kubectl describe deploy $DEPLOY -n eric-ccsm | grep -i inject | grep -v true; done
sleep 3

echo "Save the software versions"
kubectl describe deploy -n eric-ccsm | grep -i chart | tee sw_version.txt
sleep 3

echo "Save the destination rules defined"
kubectl describe destinationrules --all-namespaces | tee dr.txt
sleep 3

echo "Save the virtual services defined before the upgrade"
kubectl describe virtualservices --all-namespaces | tee vs.txt
sleep 3

echo "Save the HPA configuration before the upgrade"
kubectl get hpa --all-namespaces | tee hpa.txt
sleep 3

echo "Save the gateways defined before the upgrade"
kubectl describe gateway --all-namespaces | tee gateways.txt
sleep 3

echo "Save the information about the upgrades performed in the system"
for CHART in `helm list | awk '{print $1}' | grep -v NAME`; do echo $CHART; helm history $CHART; done | tee upgradeshistory.txt

echo "Get the values used during the deployment"
for CHART in `helm list | awk '{print $1}' | grep -v NAME`; do echo $CHART; helm get values $CHART; done | tee values.txt
for CHART in `helm list | awk '{print $1}' | grep -v NAME`; do echo $CHART; helm get values --all $CHART; done | tee valuesall.txt

#echo "Save the NF configuration (through ADP CM Yang Provider) Netconf to verify later that it has been preserved"
#NODE_IP=$(kubectl get nodes -o jsonpath='{ $.items[0].status.addresses[?(@.type=="InternalIP")].address }')
#YANG_PORT=$(kubectl get svc eric-cm-yang-provider -o jsonpath='{ .spec.ports[?(@.name=="netconf")].nodePort }' -n eric-ccsm)
#ssh -t -p $YANG_PORT admin@$NODE_IP -s netconf < ../get.xml > initialconf.xml

echo "Start to monitor the PODs load/memory and nodes load/memory/disk"
while true;do printf "\n\n">>containers.txt; date>>containers.txt;kubectl top pod --all-namespaces --containers >> containers.txt;printf "\n\n">>top_node.txt; date>>top_node.txt;kubectl top node >> top_node.txt; printf "\n\n">>top_pod.txt; date>>top_pod.txt;kubectl top pod --all-namespaces>> top_pod.txt;kubectl get hpa --all-namespaces >> get_hpa.txt; sleep 30;done &


cd -
