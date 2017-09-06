#!/bin/bash
docker kill builder 
docker rm builder
#docker run   --privileged --name=builder -v /sys/fs/cgroup:/sys/fs/cgroup:ro   -d  -p 31022:22  builder
docker run   --privileged     --name=builder -d   -p 31022:22  builder
