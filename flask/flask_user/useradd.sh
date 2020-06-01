#! /bin/bash
cp -n /bin/bash /bin/rbash

mkdir -p ./flask_user/programs
ln -s /usr/bin/docker ./flask_user/programs/

cp ./.bash_profile ./flask_user

mkdir ./flask_user/.ssh
cp ./.ssh/docker_key.pub ./flask_user/.ssh/authorized_keys

userdel -r flask_user > /dev/null
useradd -s /bin/rbash -G docker flask_user
cp -rf ./flask_user /home/
chown -R flask_user /home/flask_user
rm -rf ./flask_user
