FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3-pip python3-numpy \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/docker
COPY predict /home/docker
ENV PATH=$PATH:/home/docker

