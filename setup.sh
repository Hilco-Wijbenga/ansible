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

rm -rf /root/.ssh
ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ''

chmod u=rwx,go= /etc/ansible/.ssh
chmod u=rw,go=  /etc/ansible/.ssh/id_rsa
chmod u=rw,go=r /etc/ansible/.ssh/id_rsa.pub
cp /etc/ansible/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod u=rw,go= /root/.ssh/authorized_keys
restorecon -R -v /root/.ssh

su - ansible -c "ansible -vvvv all -m ping"
