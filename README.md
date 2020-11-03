Java Base Images
================

## Release a new version
After changing versions in the Dockerfile and the login to github container registry, run:

    docker build -t ghcr.io/stroeer/distroless-java-grpc:11 .

    docker push ghcr.io/stroeer/distroless-java-grpc:11