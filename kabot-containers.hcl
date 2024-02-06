group "default" {
    targets = ["base-os"]
}


target "base-os" {
    dockerfile = "base-os.Dockerfile"
    args = {
        ROS_DISTRO = "humble"
    }
}