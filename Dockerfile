# syntax=docker/dockerfile:experimental
# gcc 9.3.0 with intel tbb
#
# VERSION 0.1

# gcc base image
FROM gcc:9.3.0 AS release

# intel tbb
ARG TBB=https://github.com/oneapi-src/oneTBB/releases/download/v2020.2/tbb-2020.2-lin.tgz

# install required packages: vim, gdb
RUN --mount=target=/var/lib/apt/lists,type=cache \
    --mount=target=/var/cache/apt,type=cache \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       vim \
       gdb \
# install tbb
    && cd /opt \
    && wget -O pstl-tbb.tgz ${TBB} \
    && tar -xf pstl-tbb.tgz; rm -rf pstl* \
    && chmod u+x tbb/bin/* \
# modify the .bashrc to source the tbb environment variable
    && echo "source /opt/tbb/bin/tbbvars.sh intel64 linux auto_tbbroot" >> /root/.bashrc

