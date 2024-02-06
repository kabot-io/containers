FROM ubuntu:22.04 as base
LABEL org.opencontainers.image.source https://github.com/kabot-io/containers

ARG DEBIAN_FRONTEND=noninteractive
ARG ROS_DISTRO

RUN apt-get update && apt-get install -y \
        locales \
        curl \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN apt-get update && apt-get install -y \
        software-properties-common \
    && add-apt-repository universe \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt-get update && apt-get upgrade -y 

RUN apt-get update && apt-get install -y \
        ros-${ROS_DISTRO}-ros-base \
    && rm -rf /var/lib/apt/lists/*