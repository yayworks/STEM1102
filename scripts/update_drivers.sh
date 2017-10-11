#!/bin/bash

exec add-apt-repository ppa:oibaf/graphics-drivers <<EOF

EOF
exec apt-get update
exec apt-get upgrade
