#!/bin/bash
docker stop app proxy
docker rm app proxy

docker_engine_ip="$(ifconfig docker0 | grep inet -m 1 | awk {'print $2'})"
docker run -dit --add-host docker_engine:$docker_engine_ip --name app app_image

app_ip=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' app`
docker run -dit --add-host app:$app_ip --name proxy -p 80:80 proxy_image

curl 127.0.0.1:80
