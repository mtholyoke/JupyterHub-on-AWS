#!/bin/bash

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

# space separated email addresses for students
# students - there should be at least one
students=""

# SSL variables
cert_key="comsc243jupyterhub.mtholyoke.edu.key"
cert="comsc243jupyterhub_mtholyoke_edu_cert.cer"
cert_interm="comsc243jupyterhub_mtholyoke_edu_interm.cer"

# Removed these because they are secrets 
auth_client_id=""
auth_client_secret=""

# Cull idle notebooks if inactive for some number of seconds
secs_to_time_out=5400


####################################
# Implement changes using variables
####################################

# consider ensuring underlying packages are present
sudo apt install python3 python3-dev git curl

# install tljh variant of JupyterHub
curl -L https://tljh.jupyter.org/bootstrap.py | sudo -E python3

# setup shared folder
sudo mkdir -p /srv/data/$course_name
cd /etc/skel
sudo ln -s /srv/data/$course_name $course_name
cd /home/ubuntu

# add administrative users
for ADMIN in $administrators
do
        sudo tljh-config add-item users.admin $ADMIN
done

# add allowed users
for STUDENT in $students
do
        sudo tljh-config add-item users.allowed $STUDENT
done

# key file - move and set permissions
sudo mv $cert_key /etc/ssl/private
sudo chown root:root /etc/ssl/private/$cert_key
sudo chmod 600 /etc/ssl/private/$cert_key

# cert - move and set permissions
sudo mv $cert /etc/ssl/certs
sudo chown root:root /etc/ssl/certs/$cert
sudo chmod 600 /etc/ssl/certs/$cert

# interim cert - move and set permissions
sudo mv $cert_interm /etc/ssl/certs
sudo chown root:root /etc/ssl/certs/$cert_interm
sudo chmod 644 /etc/ssl/certs/$cert_interm

# change config for https
sudo tljh-config set https.enabled true
sudo tljh-config set https.tls.key /etc/ssl/private/$cert_key
sudo tljh-config set https.tls.cert /etc/ssl/certs/$cert

sudo tljh-config reload proxy


# setup google authenticator
sudo tljh-config set auth.GoogleOAuthenticator.client_id $auth_client_id
sudo tljh-config set auth.GoogleOAuthenticator.client_secret $auth_client_secret
sudo tljh-config set auth.GoogleOAuthenticator.oauth_callback_url https://$hub_url/hub/oauth_callback

sudo tljh-config set auth.type oauthenticator.google.GoogleOAuthenticator


# sudo tljh-config reload

# change seconds to time out if notebook is idle
sudo tljh-config set services.cull.timeout $secs_to_time_out


####################################
# Finish up
####################################≠≠

#don't know why this doesn't work
#sudo tljh-config reload proxy
sudo tljh-config reload

echo "Script complete!"
echo "Contents of /srv/data/"
ls -al /srv/data/
echo "Contents of /etc/skel"
ls -al /etc/skel
echo "New config file settings:"
sudo tljh-config show