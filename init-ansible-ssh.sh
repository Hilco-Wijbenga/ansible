#!/bin/bash

chmod u=rwx,go= /etc/ansible/.ssh
chmod u=rw,go=  /etc/ansible/.ssh/id_rsa
chmod u=rw,go=r /etc/ansible/.ssh/id_rsa.pub

cp /etc/ansible/.ssh/id_rsa.pub /root/.ssh/authorized_keys
restorecon -R -v /root/.ssh
