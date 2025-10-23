#!/bin/bash

set -x

userdata=$(ec2-metadata -d|sed "s/^user-data: *//");
#userdata='tv-ngx_lua force=1 opsboy_branch=or-1.29.2'
if [ "$userdata" = "not available" ]; then
     exit 1
fi

ps aux | grep openresty-tester.pl | grep -v grep > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "openresty-tester.pl already running"
    exit 1
fi

diff /etc/systemd/system/openresty-tester.service /home/ec2-user/openresty-tester.service
if [ $? -ne 0 ]; then
    echo "please copy /home/ec2-user/git/opsboy/misc/openresty-tester.service to /home/ec2-user/openresty-tester.service and run systemctl daemon-reload"
    exit 1
fi

mkdir -p /home/ec2-user/build
chown ec2-user:ec2-user /home/ec2-user/build
ln -s /home/ec2-user/build /tmp/build
sudo chown -R ec2-user:ec2-user /home/ec2-user/git/opsboy
sudo -u ec2-user /usr/bin/git config pull.rebase true
sudo -u ec2-user /usr/bin/git reset --hard
sudo -u ec2-user /usr/bin/git checkout master
sudo -u ec2-user /usr/bin/git pull
/usr/bin/make -j2 | tee make.log
misc/openresty-tester-wrapper $userdata 2>&1 | tee test.log
