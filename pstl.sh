#!/bin/bash
# startup gcc container with pstl support
set -e

LOCAL_SRC_ROOT=`pwd`
CPSTL_SRC_ROOT=/root/src
IMAGE=jtcheng/pstl:v0.1

docker run -it --rm -h pstl -v $LOCAL_SRC_ROOT:$CPSTL_SRC_ROOT -w $CPSTL_SRC_ROOT $IMAGE /bin/bash

