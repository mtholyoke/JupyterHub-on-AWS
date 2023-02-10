#!/bin/bash

## make sure it's being run as root
the_user=$(whoami) 
if [ "$the_user" != "root" ] 
then
	echo "please run this script as root" && exit
fi

####################################
# Variables
####################################

# course name for shared folder
course_name="COMSC_243_shared"

#course url
hub_url="comsc243jupyterhub.mtholyoke.edu" 

# space separated email addresses for admins
# admins - there should be at least one
administrators=""

# Roster from my.mtholyoke. This file should be in the current directory. 
ROSTER=Roster_for_2022FA_SOCI216TX01_11-07-2022_211718.xls

# SSL variables
cert_key="comsc243jupyterhub.mtholyoke.edu.key"
cert="comsc243jupyterhub_mtholyoke_edu_cert.cer"
cert_interm="comsc243jupyterhub_mtholyoke_edu_interm.cer"

# Removed these because they are secrets 
auth_client_id=""
auth_client_secret=""

# User CPU limit - borrowed from Data8 documentation
user_cpu_limit=2

# User memory limit - borrowed from Data8 documentation
user_memory_limit="4G"

# Cull idle notebooks if inactive for some number of seconds
secs_to_time_out=5400


####################################
# Implement changes using variables
####################################

# update all apt listings and ensure underlying packages are installed
apt update && apt install -y python3 python3-dev git curl

# install tljh variant of JupyterHub
#curl -L https://tljh.jupyter.org/bootstrap.py | sudo -E python3
curl -L https://tljh.jupyter.org/bootstrap.py | python3

# setup shared folder
mkdir -p /srv/data/$course_name
cd /etc/skel
ln -s /srv/data/$course_name $course_name
cd /home/ubuntu

# add administrative users
for ADMIN in $administrators
do
        tljh-config add-item users.admin $ADMIN
done

# START ADD STUDENTS FROM CSV 
# add allowed users

# get the line number that matches the string to remove footer
ROSTER_LEN=`awk '/Waitlisted Students:/{ print NR; exit }' $ROSTER`

# Adjust where to cut the footer
let ROSTER_LEN-=1

# set the delineator to tabs. Not sure what OLDIFS does.
OLDIFS=$IFS
IFS='	'

# not sure what this does
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }

# while loop to identify the emails. 
# the done line does three things: 
# 1. targets the third column, 2. gets rid of last few lines, 3. gets rid of the first few lines
while read -r Email
do
	tljh-config add-item users.allowed $Email
done < <(cut -d '	' -f3 $ROSTER | head -n $ROSTER_LEN | tail -n +4)

# not sure what this does
IFS=$OLDIFS

# END ADD STUDENTS FROM CSV 

# key file - move and set permissions
mv $cert_key /etc/ssl/private
chown root:root /etc/ssl/private/$cert_key
chmod 600 /etc/ssl/private/$cert_key

# cert - move and set permissions
mv $cert /etc/ssl/certs
chown root:root /etc/ssl/certs/$cert
chmod 600 /etc/ssl/certs/$cert

# interim cert - move and set permissions
mv $cert_interm /etc/ssl/certs
chown root:root /etc/ssl/certs/$cert_interm
chmod 644 /etc/ssl/certs/$cert_interm

# change config for https
tljh-config set https.enabled true
tljh-config set https.tls.key /etc/ssl/private/$cert_key
tljh-config set https.tls.cert /etc/ssl/certs/$cert

tljh-config reload proxy


# setup google authenticator
tljh-config set auth.GoogleOAuthenticator.client_id $auth_client_id
tljh-config set auth.GoogleOAuthenticator.client_secret $auth_client_secret
tljh-config set auth.GoogleOAuthenticator.oauth_callback_url https://$hub_url/hub/oauth_callback

tljh-config set auth.type oauthenticator.google.GoogleOAuthenticator

# change user resource limits
tljh-config set limits.cpu $user_cpu_limit
tljh-config set limits.memory $user_memory_limit

# change seconds to time out if notebook is idle
tljh-config set services.cull.timeout $secs_to_time_out


####################################
# Finish up
####################################

#don't know why this doesn't work
#tljh-config reload proxy
tljh-config reload

echo "Script complete!"
echo "Contents of /srv/data/"
ls -al /srv/data/
echo "Contents of /etc/skel"
ls -al /etc/skel
echo "New config file settings:"
tljh-config show
