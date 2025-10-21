#!/bin/bash

set -x

userdata=$(ec2-metadata -d|sed "s/^user-data: *//");
#userdata='t-lua-resty-redis to-lua-resty-websocket force=1 opsboy_branch=nginx-1.29.2'
if [ "$userdata" = "not available" ]; then
     exit 1
fi

ps aux | grep openresty-tester.pl | grep -v grep > /dev/null 2>&1
if [ $? = 0 ]; then
    echo "openresty-tester.pl already running"
    exit 1
fi

mkdir -p /home/ec2-user/build
chown ec2-user:ec2-user /home/ec2-user/build
ln -s /home/ec2-user/build /tmp/build
if [ ! -f /opt/luajit/share/luajit-2.1/cjson.so ]; then
    sudo cp /usr/local/openresty-debug/lualib/cjson.so /opt/luajit/share/luajit-2.1/
fi
sudo chown -R ec2-user:ec2-user /home/ec2-user/git/opsboy
sudo -u ec2-user /usr/bin/git config pull.rebase true
sudo -u ec2-user /usr/bin/git reset --hard
sudo -u ec2-user /usr/bin/git pull
/usr/bin/make -j2 | tee make.log
misc/openresty-tester-wrapper $userdata 2>&1 | tee test.log
