#!/bin/bash
#docker run   --privileged  -v /sys/fs/cgroup:/sys/fs/cgroup:ro  --rm --tty --interactive  -p 31022:22  builder
docker run   --privileged   --rm --tty --interactive  -p 31022:22  builder

