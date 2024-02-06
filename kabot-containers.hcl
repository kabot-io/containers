group "default" {
    targets = ["base-ros", "ros-dev", "ros-desktop"]
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

target "base-ros" {
    dockerfile = "base-ros.Dockerfile"
    tags = ["ghcr.io/kabot-io/base-ros:${TAG}"]

    cache-from = ["type=registry,ref=ghcr.io/kabot-io/base-ros:${TAG}"]
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
        base-ros = "target:base-ros"
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
