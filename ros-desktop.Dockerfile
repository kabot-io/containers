FROM ros-dev
LABEL org.opencontainers.image.source https://github.com/kabot-io/containers

ARG DEBIAN_FRONTEND=noninteractive
ARG ROS_DISTRO

RUN apt-get update && apt-get install -y \
        ros-${ROS_DISTRO}-desktop \
    && rm -rf /var/lib/apt/lists/*

USER $USERNAME
