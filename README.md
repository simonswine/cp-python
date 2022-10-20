# Continuous Profiling for Python

The use of [zprofile] requires to build the wheel for the particular libraries shipped, locally refer to the [Dockerfile] how to achieve this.

## Run backend

```shell
$ docker run -p 8081:8081 docker.io/simonswine/cp-python:0.1.0
```

## Collect profiles

```shell
$ pprof -http :6060 "http://localhost:8081/debug/pprof/profile?seconds=1"
```

