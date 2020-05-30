#!/bin/bash

#ssh-keygen -t rsa -C docker -f /root/docker_test/docker_key -q -N "" \
#	2>/dev/null <<< y >/dev/null

#cat /root/docker_test/docker_key.pub >> /root/.ssh/authorized_keys

docker build -t app_image \
--build-arg ssh_prv_key="$(cat /root/proj/flask/docker_test/docker_key)" \
--build-arg ssh_pub_key="$(cat /root/proj/flask/docker_test/docker_key.pub)" \
.
docker tag app_image art200109/app_image
docker push art200109/app_image
