group "default" {
    targets = ["ros-base", "ros-dev", "ros-desktop", "ros-platformio"]
}

variable "TAG" {
  default = "latest"
}

variable "common_args"  {
    default = {
        ROS_DISTRO = "humble"
        HOST_UID = "1000"
        HOST_GID = "1000"
        USERNAME = "ros"
    }
}

target "ros-base" {
    dockerfile = "ros-base.Dockerfile"
    tags = ["ghcr.io/kabot-io/ros-base:${TAG}"]

    cache-from = ["type=registry,ref=ghcr.io/kabot-io/ros-base:${TAG}"]
    cache-to = ["type=inline"]

    args = common_args
    platforms = ["linux/amd64", "linux/arm64"]
}

target "ros-dev" {
    dockerfile = "ros-dev.Dockerfile"
    tags = ["ghcr.io/kabot-io/ros-dev:${TAG}"]

    cache-from = ["type=registry,ref=ghcr.io/kabot-io/ros-dev:${TAG}"]
    cache-to = ["type=inline"]

    args = common_args
    platforms = ["linux/amd64", "linux/arm64"]
    contexts = {
        ros-base = "target:ros-base"
    }
}

target "ros-desktop" {
    dockerfile = "ros-desktop.Dockerfile"
    tags = ["ghcr.io/kabot-io/ros-desktop:${TAG}"]
    args = common_args

    cache-from = ["type=registry,ref=ghcr.io/kabot-io/ros-desktop:${TAG}"]
    cache-to = ["type=inline"]

    platforms = ["linux/amd64"]
    contexts = {
        ros-dev = "target:ros-dev"
    }
}

target "ros-platformio" {
    dockerfile = "ros-platformio.Dockerfile"
    tags = ["ghcr.io/kabot-io/ros-platformio:${TAG}"]
    args = common_args

    cache-from = ["type=registry,ref=ghcr.io/kabot-io/ros-platformio:${TAG}"]
    cache-to = ["type=inline"]

    platforms = ["linux/amd64"]
    contexts = {
        ros-desktop = "target:ros-desktop"
    }
}
