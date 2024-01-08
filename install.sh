#!/bin/bash
#
cp -p --update=all fake-time-sync.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable fake-time-sync.service
