#!/bin/bash

yum -y install epel-release
yum -y install ansible git

if id ansible >/dev/null 2>&1; then
    userdel ansible
fi

rm -rf /etc/ansible
useradd -d /etc/ansible -m -r -s /bin/bash ansible
rm -rf /etc/ansible/.??* /etc/ansible/*

su - ansible -c "git clone https://github.com/Hilco-Wijbenga/ansible.git ."
