# docker-images

This repo contains custom docker images used for buzz Fargate tasks.

## Images

### java_21

* based on [eclipse-temurin](https://hub.docker.com/_/eclipse-temurin) with [grpcurl](https://github.com/fullstorydev/grpcurl) for container health checks.
* changes will be pushed to our [registry](https://github.com/stroeer/docker-images/pkgs/container/java_21) automatically on merge to main  

### custom-fluent-bit

**This should be refactored to use a workflow in main like `java_21`!**

* based on [aws-for-fluent-bit](https://gallery.ecr.aws/aws-observability/aws-for-fluent-bit) enhanced
with parser configuration to process envoy access and application logs.
* run `make push` in the [custom-fluent-bit](https://github.com/stroeer/docker-images/blob/custom-fluent-bit) branch to push changes our registry
