BUILD_DIRS=build.*
DEVICE_BUILD_DIRS=build.AmberELEC-RG*
TOOLCHAIN_BUILD_DIRS=build.AmberELEC-RK*

all:

system:
	./scripts/image

release:
	./scripts/image release

image:
	./scripts/image mkimage

noobs:
	./scripts/image noobs

clean:
	rm -rf $(DEVICE_BUILD_DIRS)

clean-toolchain:
	rm -rf $(TOOLCHAIN_BUILD_DIRS)

distclean:
	rm -rf ./.ccache* ./$(BUILD_DIRS)

src-pkg:
	tar cvJf sources.tar.xz sources .stamps

world:
	DEVICE=RG351P ARCH=aarch64 ./scripts/build_distro
	DEVICE=RG351V ARCH=aarch64 ./scripts/build_distro
	DEVICE=RG351MP ARCH=aarch64 ./scripts/build_distro
	DEVICE=R36S ARCH=aarch64 ./scripts/build_distro
	DEVICE=RG552 ARCH=aarch64 ./scripts/build_distro

RG351P:
	DEVICE=RG351P ARCH=aarch64 ./scripts/build_distro

RG351V:
	DEVICE=RG351V ARCH=aarch64 ./scripts/build_distro

RG351MP:
	DEVICE=RG351MP ARCH=aarch64 ./scripts/build_distro

R36S:
	DEVICE=R36S ARCH=aarch64 ./scripts/build_distro

RG552:
	DEVICE=RG552 ARCH=aarch64 ./scripts/build_distro

toolchain-RK3326:
	DEVICE=RK3326 ARCH=aarch64 ./scripts/build toolchain

toolchain-RK3399:
	DEVICE=RK3399 ARCH=aarch64 ./scripts/build toolchain

toolchain-RK3566:
	DEVICE=RK3566 ARCH=aarch64 ./scripts/build toolchain

lib32:
	DEVICE=RK3326 ARCH=arm ./scripts/build toolchain
	DEVICE=RG351P ARCH=arm scripts/clean build-lib32
	DEVICE=RG351P ARCH=arm scripts/build build-lib32
	DEVICE=RG351V ARCH=arm scripts/clean build-lib32
	DEVICE=RG351V ARCH=arm scripts/build build-lib32
	DEVICE=RG351MP ARCH=arm scripts/clean build-lib32
	DEVICE=RG351MP ARCH=arm scripts/build build-lib32
	DEVICE=RK3399 ARCH=arm ./scripts/build toolchain
	DEVICE=RG552 ARCH=arm scripts/clean build-lib32
	DEVICE=RG552 ARCH=arm scripts/build build-lib32
	DEVICE=RK3566 ARCH=arm ./scripts/build toolchain

update:
	DEVICE=RG552 ARCH=aarch64 ./scripts/update_packages

package:
	./scripts/build ${PACKAGE}

package-clean:
	./scripts/clean ${PACKAGE}
