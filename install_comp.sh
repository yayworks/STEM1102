
#!/bin/bash

wget https://s3.amazonaws.com/gen-purpose/pgilinux-2018-184-x86-64.tar.gz
tar xvfz pgilinux-2018-184-x86-64.tar.gz
rm pgilinux-2018-184-x86-64.tar.gz

/home/nimbix/expect.sh
