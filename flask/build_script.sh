#!/bin/bash
mkdir ./.ssh/
ssh-keygen -t rsa -C docker -f ./.ssh/docker_key -q -N "" <<< y

chmod u+x ./flask_user/useradd.sh
./flask_user/useradd.sh

docker build -t app_image \
--build-arg ssh_prv_key="$(cat ./.ssh/docker_key)" \
--build-arg ssh_pub_key="$(cat ./.ssh/docker_key.pub)" \
.

docker tag app_image art200109/app_image
docker push art200109/app_image
