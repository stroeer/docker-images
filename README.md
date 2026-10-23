# docker-images

This repo contains custom docker images used for buzz Fargate tasks.

## Tagging

Images are automatically tagged with an inferred version from the last `FROM` line in a Dockerfile, see
[publish.yml](./.github/workflows/publish.yml). When adding a new Dockerfile, ensure that it works with the step that
does the extraction ("Determine upstream version").

The following tags are created:

```text
$version-$short_sha (immutable)
$version (mutable)
latest (mutable)

# e.g.
1.40.1-23c7662
1.40.1
latest
```

## Images

### java_25

* based on [eclipse-temurin](https://hub.docker.com/_/eclipse-temurin) with [grpc-health-probe](https://github.com/grpc-ecosystem/grpc-health-probe) for container health checks.
* changes will be pushed to our registry
* [java 25](https://github.com/stroeer/docker-images/pkgs/container/java_25) automatically on merge to main
