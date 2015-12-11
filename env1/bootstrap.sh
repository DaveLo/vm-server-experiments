#!/usr/bin/env bash

apt-get update > /dev/null 2>&1
apt-get install -y apache2 > /dev/null 2>&1
apt-get upgrade -y