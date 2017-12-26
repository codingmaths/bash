#!/bin/bash

################################################################################

# This script will check to see if a website is up/down by pinging the url
# If there is no response a Slack Notification will be send when the site is Down
# If the site status is down a Slack Notification will be send when the site is up again

# set your check interval here :-) #############################################
interval=180 # 3 mins

# begin status ; DO NOT CHANGE #################################################
stat=0 # this is the status UP; status 1 is DOWN

# your url #####################################################################
url="https://google.com"

# slack settings ###############################################################

slack(){ # subject message
  SLACK_WEBHOOK_URL="https://hooks.slack.com/services/{Slack_Token}"
  SLACK_CHANNEL="#sanjay-test"
  SLACK_BOTNAME="Elasticseach"
  PAYLOAD="payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"${SLACK_BOTNAME}\", \"text\": \"$1 *HOST*: <${url}> \n\n *STATE*: $2 \n \"}"
  curl --connect-timeout 30 --max-time 60 -s -S -X POST --data-urlencode "${PAYLOAD}" "${SLACK_WEBHOOK_URL}"
}

# check url ################################################################

while :
do
  wget --server-response --spider $url

  if [ "$?" -eq 0 ] # so if we have exit status of zero then server is UP
  then

    if [ "$stat" -eq 1 ]
    then
    HOSTSTATE=`up`
    ICON=":beer:"
    slack $ICON $HOSTSTATE
      stat=0
    fi
  else
    # same as above but the other way around
    if [ "$stat" -eq 0 ]
    then
    HOSTSTATE="DOWN"
    ICON=":fire:"
    slack $ICON $HOSTSTATE
      stat=1
    fi
  fi

  sleep $interval

done

exit
