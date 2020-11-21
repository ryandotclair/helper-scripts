#!/bin/sh

# This script removes any namespaces stuck in "Terminating" state in kubernetes
# It's following the advice found here:
# https://www.ibm.com/support/knowledgecenter/SSBS6K_3.2.x/troubleshoot/ns_terminating.html
# Recommend running this in a folder that only this script lives in as it deletes .json files.

read \?"Run 'kubectl proxy' in another terminal and then his [ENTER] to continue this script."
echo "Grabbing all namespaces that are stuck in Termanating"
kubectl get ns | grep Term | awk '{print $1}' > list.txt
echo "Building out the json files"
while IFS= read -r string
do
    kubectl get ns "$string" -o json > "$string".json
done < list.txt
echo "Removing kubernetes as a blocker from the finalizer"
sed -i -e 's/"kubernetes"//g' *.json
echo "Sending the API command to patch the namespace with the new state"
while IFS= read -r string
do
	curl -k -H "Content-Type: application/json" -X PUT --data-binary @"$string".json http://127.0.0.1:8001/api/v1/namespaces/"$string"/finalize
done < list.txt
echo "Cleaning up the files."
rm *.json
rm list.txt
rm *.json-e
