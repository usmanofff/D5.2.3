#!/bin/bash
git clone git@github.com:SkillfactoryCoding/DEVOPS-Helm-helm-charts.git

cd DEVOPS-Helm-helm-charts/charts/prometheus && helm dependency build && helm -n prometheus install prometheus-apps .

helm -n prometheus upgrade prometheus-apps . --set alertmanager.enabled=false, --set pushgateway.enabled=false, --set nodeExporter.enabled=false

count=1
while  [ $count -le 10 ]
do
kubectl -n prometheus get po
  echo $count
 sleep 1
  count=$(( $count + 1 ))
done

helm -n prometheus uninstall prometheus-apps 

