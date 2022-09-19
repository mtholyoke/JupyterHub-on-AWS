#!bin/bash 

# update apt-get at start of script
sudo apt-get update

sudo apt -y install python3 python3-dev git curl

curl -L https://tljh.jupyter.org/bootstrap.py | sudo -E python3

sudo mkdir -p /srv/data/DS_1_shared
cd /etc/skel
sudo ln -s /srv/data/DS_1_shared DS_1_shared
cd /home/ubuntu

# add users - for each user, add user with permission level and email 

sudo tljh-config add-item users.admin bgebreme@mtholyoke.edu
sudo tljh-config add-item users.admin jsidman@mtholyoke.edu
sudo tljh-config add-item users.admin dyoung@mtholyoke.edu
sudo tljh-config add-item users.admin kmulder@mtholyoke.edu

sudo tljh-config add-item users.allowed student1@mtholyoke.edu
sudo tljh-config add-item users.allowed student2@mtholyoke.edu
sudo tljh-config add-item users.allowed student3@mtholyoke.edu
sudo tljh-config add-item users.allowed student4@mtholyoke.edu
sudo tljh-config add-item users.allowed student5@mtholyoke.edu
sudo tljh-config add-item users.allowed student6@mtholyoke.edu

# YOU CAN NOT TEST THIS IF YOU DON’T HAVE THE SPECIAL FILES
# sudo mv dsjupyterhub.mtholyoke.edu.key /etc/ssl/private
# sudo chown root:root /etc/ssl/private/dsjupyterhub.mtholyoke.edu.key
# sudo chmod 600 /etc/ssl/private/dsjupyterhub.mtholyoke.edu.key

# # YOU CAN NOT TEST THIS IF YOU DON’T HAVE THE SPECIAL FILES
# sudo mv dsjupyterhub_mtholyoke_edu_cert.cer /etc/ssl/certs
# sudo chown root:root /etc/ssl/certs/dsjupyterhub_mtholyoke_edu_cert.cer
# sudo chmod 600 /etc/ssl/certs/dsjupyterhub_mtholyoke_edu_cert.cer

# # YOU CAN NOT TEST THIS IF YOU DON’T HAVE THE SPECIAL FILES
# sudo mv dsjupyterhub_mtholyoke_edu_interm.cer /etc/ssl/certs
# sudo chown root:root /etc/ssl/certs/dsjupyterhub_mtholyoke_edu_interm.cer
# sudo chmod 644 /etc/ssl/certs/dsjupyterhub_mtholyoke_edu_interm.cer

# # YOU CAN NOT TEST THIS IF YOU DON’T HAVE THE SPECIAL FILES
# sudo tljh-config set https.enabled true
# sudo tljh-config set https.tls.key /etc/ssl/private/dsjupyterhub.mtholyoke.edu.key
# sudo tljh-config set https.tls.cert /etc/ssl/certs/dsjupyterhub_mtholyoke_edu_cert.cer

# sudo tljh-config reload proxy

# # YOU CAN NOT TEST THIS IF YOU DON’T HAVE THE SPECIAL FILES
# sudo tljh-config set auth.GoogleOAuthenticator.client_id <SOME_SPEICIAL_CLIENT_ID>
# sudo tljh-config set auth.GoogleOAuthenticator.client_secret <SOME_SPEICIAL_CLIENT_SECRET>
# sudo tljh-config set auth.GoogleOAuthenticator.oauth_callback_url https://dsjupyterhub.mtholyoke.edu
# /hub/oauth_callback

# # YOU CAN NOT TEST THIS IF YOU DON’T HAVE THE SPECIAL FILES
# sudo tljh-config set auth.type oauthenticator.google.GoogleOAuthenticator

# sudo tljh-config set services.cull.timeout 5400

# sudo tljh-config reload


# test that the hub has been created

# create new instances that would allow us to add users

# test that users have been added? 