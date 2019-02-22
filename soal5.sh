#!/bin/bash

awk '(/cron/ || /CRON/) && (!/sudo/) && (NF < 13) {print}' /var/log/syslog >> /home/kyielas/modul1/kyielas.log


