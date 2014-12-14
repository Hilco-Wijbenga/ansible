#!/bin/bash

rm -rf /root/.ssh
ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ''
