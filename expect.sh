#!/usr/bin/expect

spawn sudo /usr/local/install
expect "Press "
send "\n"
expect "NVIDIA "
send "q"
expect "Do you"
send "accept\n"
expect "A network"
send "1\n"
expect "Please specify"
send "\n"
expect "Press "
send "\n"
expect "In order "
send "q"
expect "Do you"
send "accept\n"
expect "Press "
send "\n"
expect "In order "
send "q"
expect "Do you"
send "accept\n"
expect "Do you wish to update"
send "y\n"
expect "Press "
send "\n"
expect "Do you want to install Open MPI onto your system?"
send "y\n"
expect "Do you want to enable NVIDIA GPU support in Open MPI?"
send "y\n"
expect "Do you wish to obtain permanent license key or configure license service?"
send "n\n"
expect "Do you want the files in the install directory to be read-only?"
send "y\n"
