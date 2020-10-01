#!/bin/bash

yum update -y;
wait;
yum install -y epel-release
wait;
yum install -y ansible
