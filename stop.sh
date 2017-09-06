#!/bin/bash
docker kill  `docker ps  | grep builder | awk   ' { print $1} '`
