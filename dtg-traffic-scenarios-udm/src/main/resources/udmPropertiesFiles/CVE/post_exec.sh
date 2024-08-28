#!/bin/bash

mkdir POST
cd POST

echo "1.- Get the counters (manual)"

echo "2.- Stop to monitor the PODs load/memory and nodes load/memory/disk"
kill -9 $(ps -ef | grep $(whoami) | grep load | grep -v color | awk {'print $2'})

echo "3.- Save all POD logs since the beginning of the test, excluding the DEBUG and INFO ones"
mkdir podlogs

for POD in `kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n eric-ccsm | grep -vE 'ausf-st|udrsim|testrunner|job|eric-cm|eric-data|eric-fh|eric-odca|eric-pm'`;do echo $POD;kubectl logs $POD -n eric-ccsm --timestamps=true --since=1000s --all-containers=true | grep -vE 'debug|info' > podlogs/all_containers_$POD.log;done

for POD in `kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n eric-ccsm | grep -vE 'ausf-st|udrsim|testrunner|job|eric-cm|eric-data|eric-fh|eric-odca|eric-pm'`;do echo $POD;kubectl logs $POD -n eric-ccsm --timestamps=true --since=1000s -c `kubectl get po -n eric-ccsm $POD -o json | grep -i "\"app\"" | grep -v key | awk -F "\"" '{print $4}'`| grep -vE 'debug|info' > podlogs/logs_$POD.log;done

echo "4.-Save nodes info"
kubectl describe node | tee post_node.txt

echo "5.- Save the deployment info"
kubectl describe deploy --all-namespaces | tee post_deploy.txt

echo "6.-Save the pods information including the number of restarts to be compared in the post-execution phase"
kubectl get po --all-namespaces -o wide | sort --reverse --key 5 --numeric | tee post_pod.txt

echo "7.- Save the services running"
kubectl get svc --all-namespaces | tee post_svc.txt

echo "8.- Save the events in the system"
kubectl get events --sort-by='.metadata.creationTimestamp' --all-namespaces | tee post_events.txt

echo "9.- Save the number of PODs per node"
for node in `kubectl get nodes -o wide | awk '{print $1}' | grep -v NAME`;do kubectl get po --all-namespaces -o wide | grep -i $node | wc -l;done | tee post_numpod_node.txt

echo "10.- Save the total number of PODs"
kubectl get po --all-namespaces -o wide | grep -v NAME | wc -l | tee post_numpod.txt

echo "11.- Save the resources used by all nodes. Notice that there is not always an even distribution, especially if robustness TCs have been executed in the envioronment before"
kubectl top nodes | tee post_topnodes.txt

echo "12.- Save the replicaset information (useful specially before and after upgrades)"
kubectl get rs -n eric-ccsm | tee post_rs.txt

echo "13.- Check that all pods are in status running (output should be empty)"
kubectl get pod --all-namespaces -o wide | awk '{print $4}' | grep -vE 'Running|Completed' | grep -v STATUS

echo "14.- Check that all containers have beeen started. Output should be \"All containers are up\""
kubectl -n eric-ccsm get po | grep -v Completed | awk -F"[ /]+" 'BEGIN{found=0} !/NAME/ {if ($2!=$3) { found=1; print $0}} END { if (!found) print "All containers are up"}'

echo "15.- Check that all nodes are in status Ready (output should be empty)"
kubectl get nodes | awk '{print $2}' | grep -v Ready | grep -v STATUS

echo "16.- Save and check that there are no alarms"
HOST=$(kubectl get nodes -o jsonpath='{ $.items[0].status.addresses[?(@.type=="InternalIP")].address }')
PORT=$(kubectl get svc -n eric-ccsm eric-fh-alarm-handler -o jsonpath={.spec.ports[0].nodePort})
wget -O post_alarms.txt http://${HOST}:${PORT}/ah/api/v0.2/alarms?outputFormat=SeveritySummary

echo "17.- Save the ending time of the test to be used later on to collect the logs"
date -u +"%Y-%m-%dT%H:%M:%SZ" | tee post_date.txt

echo "18.- Save the kubectl version installed"
kubectl version | tee kubectl_version.txt

echo "19.- Save the helm version installed"
helm version | tee helm_version.txt

echo "20.- Save the software installed"
helm list | tee helm_list.txt

cd -
