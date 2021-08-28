BUILD_BASE_IMAGE=rustlang/rust:nightly
BUILD_IMAGE=rust-kernel-demo/builder

# run starts the kernel in qemu
run: rust-kernel-demo.img
	qemu-system-x86_64 -drive format=raw,file=$<

# rust-kernel-demo.img is the image we want to build
rust-kernel-demo.img: .build-image $(shell find ./src -name "*.rs")
	podman run --rm -it -v .:/app -w /app -v cargo-cache:/usr/local/cargo $(BUILD_IMAGE) \
		cargo run \
			--release \
			--target x86_64-custom.json \
			-Zbuild-std=core,alloc \
			-Zbuild-std-features=compiler-builtins-mem -- \
				--no-run
	ln -sf target/x86_64-custom/release/boot-bios-rust-kernel-demo.img $@

# .build-image constructs a container with all the requirements to build the kernel
.build-image:
	$(eval ID=$(shell buildah from $(BUILD_BASE_IMAGE)))
	buildah run -t $(ID) -- rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
	buildah run -t $(ID) -- rustup component add llvm-tools-preview
	buildah commit $(ID) $(BUILD_IMAGE)
	buildah rm $(ID)
	touch .build-image
