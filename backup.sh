#!/bin/bash
name=$(date '+%Y-%m-%d')
tar -czvf "/media/internal/dr6/backups/plutia-$name.tar.gz" /home/ /etc/systemd/system/calibre-server.service
tar -czvf "/media/internal/dr6/backups/plex-$name.tar.gz" /var/lib/plexmediaserver/
