#!/bin/bash
iptables --flush;
service iptables save;
service iptables stop;
chkconfig iptables off;
