#!/bin/bash

mkdir -p /home/vagrant/cache
chown vagrant:vagrant /home/vagrant/cache
grep -q -F 'export PATH=$PATH:/vagrant/bin' /etc/profile || echo 'export PATH=$PATH:/vagrant/bin' >> /etc/profile

