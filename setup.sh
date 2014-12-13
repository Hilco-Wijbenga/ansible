#!/bin/bash

HERE=$(dirname $0)

cat >/etc/hosts <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.0.2.15   devbox    devbox.cavebeetle.org
EOF

rm -rf /root/.ssh
mkdir -p /root/.ssh
chmod u=rwx,go= /root/.ssh
cp $HERE/files/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chmod u=rw,go= /root/.ssh/authorized_keys
restorecon -R -v /root/.ssh

yum -y install epel-release
yum -y install ansible

rm -rf /etc/ansible

userdel ansible 2>/dev/null
useradd -d /etc/ansible -m -r -s /bin/bash ansible

cp -r $HERE/files/. /etc/ansible/
chown -R ansible:ansible /etc/ansible/

chmod u=rwx,go= /etc/ansible/.ssh
chmod u=rw,go=  /etc/ansible/.ssh/id_rsa
chmod u=rw,go=r /etc/ansible/.ssh/id_rsa.pub

mkdir -p /var/log/ansible
chown ansible:ansible /var/log/ansible

cat >/etc/rc.d/rc.local <<EOF
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local

su - ansible -c "ansible -vvvv all -m ping >/var/log/ansible/\$(date +%Y%m%dT%H%M%S).log 2>&1"
EOF

sudo -u ansible ansible -vvvv all -m ping
