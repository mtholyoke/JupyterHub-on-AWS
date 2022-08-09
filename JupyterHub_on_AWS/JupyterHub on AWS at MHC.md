# JupyterHub on AWS at MHC

Instructions for creating virtual machines to use as JupyterHubs in AWS. 

Additional information can be found here:

- [TLJH Documentation page for this process](https://tljh.jupyter.org/en/latest/install/amazon.html)
- [Medium post on setting up and using free AWS EC2s](https://medium.com/@saumya.ranjan/how-to-create-an-ec2-instance-in-aws-and-access-via-ssh-f6f1292611ed)
- [Lauren’s slides about using EC2s](https://docs.google.com/presentation/d/1rBrukIqpt7z-xS60wgkfT9ThK-MGnqtPI5iXtdmuXEA/edit#slide=id.g11415d0f782_0_137)

## Create an AWS account


### Link AWS account to an *AWS Organization* (MORE TO COME)

## Log on to AWS 
![](pics/aws_com_home.png)

![](pics/aws_com_login_email.png)

![](pics/aws_com_login_pw.png)

## Search for EC2 service & select it
![](pics/aws_spash_screen.png)

![](pics/ec2_search.png)

Consider adding a star to mark as favorite
![](pics/ec2_search_favorite.png)

## Select *Launch instance*
![](pics/launch_instance.png)

## *Name* the VM
![](pics/name_vm.png)

![](pics/name_entered.png)


## Select *Application and OS Image*
![](pics/select_image.png)

![](pics/choose_ubuntu_image.png)


## Select *Instance type*
![](pics/select_instance.png)

![](pics/select_free_t2_instance.png)

## Choose *Key pair*

If you have already set up a key pair, select it using the drop down. 
![](pics/key_pair_existing.png)

If not, use the following steps to create one.
![](pics/key_pair.png)

![](pics/key_pair_new.png)

When you click **Create key pair** a key with the name and details you specified will be automatically downloaded.

Select the desired key pair name.
![](pics/key_pair_new_select.png)


## In *Network settings* create or select *security group*

### Create security group
The first time you launch a virtual machine, you will have to create a security group. Check all three boxes (SSH, HTTPs, HTTP). 
![](pics/security_basic.png)

Next, press the *Edit* button at the top of the security group section.
![](pics/security_basic_edit.png)

Name the security group.
![](pics/security_name.png)

Change HTTPs options.
![](pics/security_custom_https.png)

![](pics/security_custom_https_source_1.png)

![](pics/security_custom_https_source_2.png)

Change HTTP options.
![](pics/security_custom_http.png)

![](pics/security_custom_http_source_1.png)

![](pics/security_custom_http_source_2.png)

What you should see when you are done:
![](pics/security_done.png)

## *Select storage*
![](pics/storage.png)

## EXTRA: *Advanced details* for *User data*
Expand *Advanced details* to reveal extra settings.
![](pics/advanced_details.png)

Scroll to the bottom to edit *User data*.
![](pics/user_data.png)

Use the following general code to install TLJH automatically when the instance is created. [More info here](https://tljh.jupyter.org/en/latest/install/amazon.html#step-1-installing-the-littlest-jupyterhub).
![](pics/user_data_general.png)

The code below can be copied and pasted.

```console
#!/bin/bash
curl -L https://tljh.jupyter.org/bootstrap.py \
  | sudo python3 - \
    --admin <admin-user-name>
```

Remember to add your own name to replace the content in `<>`. 
![](pics/user_data_named.png)

The code below can be copied and pasted.

```console
#!/bin/bash
curl -L https://tljh.jupyter.org/bootstrap.py \
  | sudo python3 - \
    --admin Prof_G
```

## Launch the instance
![](pics/launch_instance_complete.png)

![](pics/launching_instance.png)

When successful click the *View all instances* button.
![](pics/launching_instance_success.png)

You may have to refresh the list.
![](pics/instances_refresh.png)

You should see the instance with the given name in the list. It may take some time to be fully available.
![](pics/instances_initalizing.png)

When the status check is green you can access the instance.
![](pics/instances_available.png)


