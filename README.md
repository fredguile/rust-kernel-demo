# rust-kernel-demo

A Hello World of build a kernel in Rust. We're building for the x86_64 target but feel free to adjust if compiling for ARM. For testing we use Qemu.

## Build

```sh
rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
rustup component add llvm-tools-preview
cargo install bootimage
cargo bootimage
```

## Run using QEMU

```sh
qemu-system-x86_64 -drive format=raw,file=target/x86_64-target/debug/bootimage-rust-kernel-demo.bin
```
