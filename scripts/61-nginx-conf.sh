#!/bin/bash
# copies nginx files to volume
if [[ -d /nginx ]]; then
    mkdir -p /etc/nginx/conf.d/omero
    cp /nginx/* /etc/nginx/conf.d/omero
else
    echo "No nginx config files provided!"
fi