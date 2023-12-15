# docker-images

This repo contains custom docker images used for buzz Fargate tasks.

## Images

### java_21

* based on [eclipse-temurin](https://hub.docker.com/_/eclipse-temurin) with [grpcurl](https://github.com/fullstorydev/grpcurl) for container health checks.
* changes will be pushed to our [registry](https://github.com/stroeer/docker-images/pkgs/container/java_21) automatically on merge to main  

### custom-fluent-bit

* based on [aws-for-fluent-bit](https://gallery.ecr.aws/aws-observability/aws-for-fluent-bit) enhanced
with parser configuration to process envoy access and application logs.
* changes will be pushed to our *AWS ECR* automatically on merge to main
