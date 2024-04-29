FROM ros-desktop
LABEL org.opencontainers.image.source https://github.com/kabot-io/containers

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*
RUN python3 -m pip install -U platformio
RUN curl -fLo /etc/udev/rules.d/99-platformio-udev.rules --create-dirs https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules
RUN echo 'SUBSYSTEMS=="usb", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE:="0666"' > /etc/udev/rules.d/99-kabot.rules