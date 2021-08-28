# rust-kernel-demo

A Hello World of build a kernel in Rust. We're building for the x86_64 target but feel free to adjust if compiling for ARM. For testing we use Qemu.

## Build

You need [buildah](https://github.com/containers/buildah) and [podman](https://podman.io/):

```sh
make
```

## Run using QEMU

```sh
make run
```
