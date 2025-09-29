# docker-images

This repo contains custom docker images used for buzz Fargate tasks.

## Images

### java_(21|22)

* based on [eclipse-temurin](https://hub.docker.com/_/eclipse-temurin) with [buf curl](https://github.com/bufbuild/buf) for container health checks.
* changes will be pushed to our registry 
([java 21](https://github.com/stroeer/docker-images/pkgs/container/java_21) 
& [java 22](https://github.com/stroeer/docker-images/pkgs/container/java_22)
& [java 25](https://github.com/stroeer/docker-images/pkgs/container/java_25)) automatically on merge to main  
