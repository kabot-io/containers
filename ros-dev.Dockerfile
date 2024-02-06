FROM base-ros
LABEL org.opencontainers.image.source="https://github.com/kabot-io/containers"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
        ros-dev-tools \
    && rm -rf /var/lib/apt/lists/*