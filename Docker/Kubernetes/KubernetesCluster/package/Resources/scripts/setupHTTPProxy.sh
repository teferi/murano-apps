#!/bin/bash

export http_proxy="$1"
echo "export http_proxy=\"$http_proxy\"" >> /etc/default/docker

service docker restart
