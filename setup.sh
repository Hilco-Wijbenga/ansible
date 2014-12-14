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

cat >/etc/hosts <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.0.2.15   devbox    devbox.cavebeetle.org
EOF

/etc/ansible/init-root-ssh.sh
/etc/ansible/init-ansible-ssh.sh

su - ansible -c "ansible -vvvv all -m ping"
