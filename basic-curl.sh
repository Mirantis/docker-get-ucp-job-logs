#!/bin/bash

read -p 'Username: ' USERNAME
read -sp 'Password: ' PASSWORD
echo
read -p 'UCP URL: ' UCP_URL
read -p 'Job ID: ' JOB_ID
if [[ -z "$JOB_ID" ]]
then
	echo "INFO: Job is blank. Pulling all jobs"
	curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/" | tee jobs.json
	exit 0
fi
curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/${JOB_ID}" | tee "${JOB_ID}.json"
curl -ks -X GET --header "Accept: application/json" -u "${USERNAME}:${PASSWORD}" "https://${UCP_URL}/enzi/v0/jobs/${JOB_ID}/logs" | tee "${JOB_ID}.logs"
