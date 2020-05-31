#!/bin/bash

docker build -t proxy_image .
docker tag proxy_image art200109/proxy_image
docker push art200109/proxy_image
