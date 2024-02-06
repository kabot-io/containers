group "default" {
    targets = ["base-os"]
}

variable "TAG" {
  default = "latest"
}

target "base-os" {
    dockerfile = "base-os.Dockerfile"
    tags = ["ghcr.io/kabot-io/base-os:${TAG}"]
    args = {
        ROS_DISTRO = "humble"
    }
}