#!/bin/bash

add-apt-repository ppa:oibaf/graphics-drivers <<EOF

EOF
apt-get update
apt-get upgrade
