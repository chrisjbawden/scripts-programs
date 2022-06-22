#!/bin/sh
apt install update
apt install fail2ban -y
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
service fail2ban restart
