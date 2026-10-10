![GitHub-Mark-Dark](https://raw.githubusercontent.com/AmberELEC/website/gh-pages/docs/images/transparent_amber_elec_horiz.svg#gh-dark-mode-only)
![GitHub-Mark-Light](https://raw.githubusercontent.com/AmberELEC/website/gh-pages/docs/images/transparent_black_amber_elec_horiz.svg#gh-light-mode-only)
[![GitHub Release](https://img.shields.io/github/release/AmberELEC/AmberELEC.svg?label=latest%20release&style=flat-square&labelColor=black&color=gold)](https://github.com/AmberELEC/AmberELEC/releases/latest)
[![Downloads Latest](https://img.shields.io/github/downloads/AmberELEC/AmberELEC/latest/total?label=downloads%40latest%20release&style=flat-square&labelColor=black&color=gold)](https://github.com/AmberELEC/AmberELEC/releases/latest)
[![Downloads Prerelease](https://img.shields.io/github/downloads/AmberELEC/AmberELEC-prerelease/total?label=downloads%40prerelease%20builds&style=flat-square&labelColor=black&color=gold)](https://github.com/AmberELEC/AmberELEC-prerelease/releases)
[![Discord](https://img.shields.io/discord/777665344289898536?logo=discord&label=Discord&labelColor=black&color=gold)](https://discord.gg/W9F9xxRseu)
---
An open source firmware for the Anbernic RG351P/M/V/MP, RG552 and other compatible devices (see listing below).

AmberELEC (formerly know as 351ELEC) is a fork of [EmuELEC](https://github.com/EmuELEC/EmuELEC) which is based on [CoreELEC](https://github.com/CoreELEC/CoreELEC), [Lakka](https://github.com/libretro/Lakka-LibreELEC), and [Batocera](https://github.com/batocera-linux/batocera.linux).

We have a [Website](https://amberelec.org) with [installation instructions](https://amberelec.org/installation#overview) and a lot of information on how to [get started using AmberELEC](https://amberelec.org/guides/getting-to-know-amberelec).

Visit us on our Discord! https://discord.gg/W9F9xxRseu

## Supported Devices
<!--devices-->
<table>
  <tr>
    <td align="center" width="70" nowrap="nowrap">SoC</td>
    <td align="center" width="150" nowrap="nowrap">Manufacturer</td>
    <td align="center" width="150" nowrap="nowrap">Device</td>
  </tr>
  <tr>
    <td>RK3399</td>
    <td>Anbernic</td>
    <td>RG552</td>
  </tr>  
  <tr>
    <td rowspan="10">RK3326</td>
    <td rowspan="4">Anbernic</td>
    <td>RG351P</td>
  </tr>
  <tr>
    <td>RG351M<sup>[1]</sup></td>
  </tr>
  <tr>
    <td>RG351V<sup>[2]</sup></td>
  </tr>
  <tr>
    <td>RG351MP<sup>[2]</sup></td>
  </tr>
  <tr>
    <td rowspan="2">PowKiddy</td>
    <td>RGB20S<sup>[3]</sup></td>
  </tr>
  <tr>
    <td>Magicx XU10<sup>[3]</sup></td>
  </tr>
  <tr>
    <td rowspan="2">Game Console<br />Game Station</td>
    <td>R35S<sup>[3]</sup></td>
  </tr>
  <tr>
    <td>R36S<sup>[3]</sup></td>
  </tr>
  <tr>
    <td>SZDiiER</td>
    <td>D007 Plus<sup>[3]</sup></td>
  </tr>
</table>
<!--devices-->

> [!IMPORTANT]
> <sup>[1]</sup> use the RG351P image<br>
> <sup>[2]</sup> for RG351V and RG351MP devices with v2 display the use of the [pre-release image](https://github.com/AmberELEC/AmberELEC-prerelease/releases) is mandatory<br>
> <sup>[3]</sup> use the RG351MP [pre-release image](https://github.com/AmberELEC/AmberELEC-prerelease/releases)

> [!CAUTION]
> Do not replace or rename any of the `.dtb` files after flashing a new image or updating from an older AmberELEC release.
> To simplify the process and reduce complexity, we're determining which display the device is using, so no manual interaction is necessary.
  
## Installation

Please visit our Website [Installation](https://amberelec.org/installation#overview) page for installation instructions.

## Building from Source
For a local R36S image on Windows, use [Building on Windows with WSL 2](#building-on-windows-with-wsl-2) below. No GitHub Enterprise subscription or GitHub Actions runner is needed.

Building AmberELEC from source is a fairly simple process. It is recommended to have a minimum of 4 cores, 16GB of RAM, and an SSD with 200GB of free space. The build environment used to develop these steps uses Ubuntu 20.04, your mileage may vary when building on other distributions.

> [!IMPORTANT]
> On Ubuntu 20.04 it's required to add the following apt-repository as golang 1.17 or higher is required for building AmberELEC:<br>
> ```sudo add-apt-repository ppa:longsleep/golang-backports```

```
sudo apt update && sudo apt upgrade

sudo apt install gcc make git unzip wget xz-utils libsdl2-dev libsdl2-mixer-dev libfreeimage-dev libfreetype6-dev libcurl4-openssl-dev rapidjson-dev libasound2-dev libgl1-mesa-dev build-essential libboost-all-dev cmake fonts-droid-fallback libvlc-dev libvlccore-dev vlc-bin texinfo premake4 golang libssl-dev curl patchelf xmlstarlet patchutils gawk gperf xfonts-utils default-jre python xsltproc libjson-perl lzop libncurses5-dev device-tree-compiler u-boot-tools rsync p7zip unrar libparse-yapp-perl zip binutils-aarch64-linux-gnu dos2unix p7zip-full libvpx-dev meson rdfind

git clone https://github.com/AmberELEC/AmberELEC.git AmberELEC

cd AmberELEC

make clean

make toolchain-RK3326
make toolchain-RK3399
make world
```

The make world process will build and generate a image which will be located in AmberELEC/release. Follow the installation steps to write your image to a microSD.
It will build for the RG351P/M, RG351V, RG351MP, R36S and RG552.

To build just one device, first build its base toolchain: `make toolchain-RK3326` for RG351P/M, RG351V, RG351MP or R36S; `make toolchain-RK3399` for RG552. Then use `make RG351P`, `make RG351V`, `make RG351MP`, `make R36S` or `make RG552`, respectively.

## Building from Source - Docker
Building with Docker simplifies the build process as any dependencies, with the exception of `make`, are contained within the docker image - all CPU/RAM/Disk/build time requirements remain similar. 

NOTE: Make can be installed with `sudo apt update && sudo apt install -y make` on Ubuntu-based systems.

All make commands are available via docker, by prepending `docker-`. `make RG351V` becomes `make docker-RG351V` and `make clean` becomes `make docker-clean`.

New docker make commands: 
- `make docker-image-build` - Builds the docker image based on the Dockerfile. This is not required unless changes are needed locally. 
- `make docker-image-pull` - Pulls the default build image from `ghcr.io/amberelec/amberelec-build`. This will replace any locally built image using the same name.
- `make docker-shell` - (advanced) Launches a shell inside the docker build container. This allows running any development commands like `./scripts/build`, etc, which aren't in the Makefile.
  - NOTE: Errors like `groups: cannot find name for group ID 1002` and the user being listed as `I have no name!` are OK and a result of mapping the host user/group into the docker container where the host user/groups may not exist.

Example building with docker:
```
git clone https://github.com/AmberELEC/AmberELEC.git AmberELEC
cd AmberELEC
make docker-clean
make docker-toolchain-RK3326
make docker-toolchain-RK3399
make docker-world
```

## Building on Windows with WSL 2

These steps build the R36S image locally using WSL 2 and this repository's Dockerfile. They do not use GitHub Actions, paid cloud runners, or a prepublished build container.

### 1. Set up Windows and WSL

- Use an x64 Windows 10/11 PC with virtualization enabled, at least 4 CPU cores, and an SSD with at least 200 GB free for the Linux build files. Allow additional space for Docker, Windows, and a decompressed image.
- The build environment should have 16 GB RAM available. WSL commonly defaults to only part of the host RAM, so ensure the PC has enough memory for both Windows and WSL. If necessary, adjust WSL's memory and processor limits in `%UserProfile%\.wslconfig`, then run `wsl --shutdown` from PowerShell and restart Docker Desktop. See [Microsoft's WSL configuration guide](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#main-wsl-settings).
- Install [Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/) under its applicable license terms. Enable **Use the WSL 2 based engine** and enable your Ubuntu distribution under **Settings → Resources → WSL Integration**. Use Linux containers, not Windows containers.

In **PowerShell as Administrator**, install Ubuntu under WSL (restart Windows if prompted):

```powershell
wsl --install -d Ubuntu
wsl --update
wsl --list --verbose
```

Open Ubuntu and create a regular Linux user when prompted. Confirm that `wsl --list --verbose` reports version **2** for Ubuntu; if it reports version 1, run `wsl --set-version Ubuntu 2` in PowerShell. The Dockerfile supplies Ubuntu 20.04 and the compiler dependencies inside the container, so you do not need to install those dependencies in the WSL host.

### 2. Get the source in the Linux filesystem

Run all remaining build commands in the **Ubuntu WSL terminal**, not PowerShell:

```bash
sudo apt update
sudo apt install -y git make
mkdir -p ~/src ~/.cache
cd ~/src
git -c core.autocrlf=false clone https://github.com/coreylad/AmberELEC.git AmberELEC
cd ~/src/AmberELEC
docker info
df -h .
free -h
```

Keep the checkout and build files under `~/src/AmberELEC`, not `/mnt/c`, OneDrive, or another Windows-mounted folder: the build needs Linux permissions, symlinks, and filesystem behavior. If you already cloned the fork inside WSL, use that checkout and select the branch containing the changes you want to build. Run `git branch --show-current` and `git log -1 --oneline` to confirm the source revision.

If `docker info` fails, start Docker Desktop and check Ubuntu's WSL integration before proceeding. Verify the available disk space and memory with the commands above. Do not run the build as root or with `sudo make`.

### 3. Build the R36S image

From `~/src/AmberELEC`, run these commands in order and stop if any command fails:

```bash
export DOCKER_IMAGE=amberelec-r36s-build:local
export CONCURRENCY_MAKE_LEVEL=4
export THREADCOUNT=4
make docker-image-build
make docker-toolchain-RK3326
make docker-R36S
```

The first command builds the Linux build environment locally. The RK3326 base toolchain must be built before the device image. Building only R36S avoids compiling every device with `make docker-world`. Keep Docker Desktop running and prevent Windows from sleeping during the build.

If compilation is killed due to insufficient memory, lower both `CONCURRENCY_MAKE_LEVEL` and `THREADCOUNT` (for example, to `2`) and rerun the failed make command. Keep the source at the same absolute Linux path between builds; do not clean before every retry, since that discards reusable device build files.

### 4. Copy and flash the image

The compressed image is written to `~/src/AmberELEC/release/aarch64/R36S/`, not to GitHub Actions artifacts. Check the output and, if your flashing tool requires a plain `.img`, decompress it while keeping the original:

```bash
ls -lh release/aarch64/R36S/*.img.gz
gzip -dk release/aarch64/R36S/*.img.gz
explorer.exe .
```

In the Explorer window, navigate to `release\aarch64\R36S` and copy the `.img` to a Windows folder, such as Downloads. Flash it to the device's firmware microSD card using a Windows image writer such as [balenaEtcher](https://etcher.balena.io/). Flashing erases the selected card; verify the target carefully. Do not flash the update `.tar` file as a disk image. Follow the [installation instructions](https://amberelec.org/installation#overview) for first boot.

Local development images are unstable and intended for testing.

## Optional GitHub Actions Builds

The R36S cloud workflow is manual-only because it requires a separately provisioned larger runner. It does not run on pushes and is not needed for the Windows WSL build. See [Build Overview](workflows/README.md) for details.
