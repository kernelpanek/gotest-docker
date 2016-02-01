#!/bin/sh

GOVERSION="1.5.3"
SRCROOT="/opt/go"
SRCPATH="/opt/gocode"

# Get the ARCH
ARCH=`uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|'`

yum update -y
yum groupinstall -y "Development Tools"
yum install -y wget curl git pcre mercurial pkgconfig zip

# Install Go
cd /tmp
wget --quiet https://storage.googleapis.com/golang/go${GOVERSION}.linux-${ARCH}.tar.gz
tar -xvf go${GOVERSION}.linux-${ARCH}.tar.gz
mv go $SRCROOT
chmod 775 $SRCROOT

# Setup the GOPATH; even though the shared folder spec gives the working
# directory the right user/group, we need to set it properly on the
# parent path to allow subsequent "go get" commands to work.
mkdir -p $SRCPATH

cat <<EOF >/tmp/gopath.sh
export GOPATH="$SRCPATH"
export GOROOT="$SRCROOT"
export PATH="$SRCROOT/bin:$SRCPATH/bin:\$PATH"
EOF
mv /tmp/gopath.sh /etc/profile.d/gopath.sh
chmod 0755 /etc/profile.d/gopath.sh
source /etc/profile.d/gopath.sh
