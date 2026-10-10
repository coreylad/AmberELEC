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

## Building on Windows with WSL 2

These steps build the R36S image directly in Ubuntu under WSL 2 on your own PC.

### 1. Set up Windows and WSL

- Use an x64 Windows 10/11 PC with virtualization enabled, at least 4 CPU cores, and an SSD with at least 200 GB free for the Linux build files. Allow additional space for Windows and a decompressed image.
- The build environment should have 16 GB RAM available. WSL commonly defaults to only part of the host RAM, so ensure the PC has enough memory for both Windows and WSL. If necessary, adjust WSL's memory and processor limits in `%UserProfile%\.wslconfig`, then run `wsl --shutdown` from PowerShell and reopen Ubuntu. See [Microsoft's WSL configuration guide](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#main-wsl-settings).

In **PowerShell as Administrator**, install Ubuntu under WSL (restart Windows if prompted):

```powershell
wsl --install -d Ubuntu-22.04
wsl --update
wsl --list --verbose
```

Open Ubuntu 22.04 and create a regular Linux user when prompted. Confirm that `wsl --list --verbose` reports version **2** for `Ubuntu-22.04`; if it reports version 1, run `wsl --set-version Ubuntu-22.04 2` in PowerShell. Use this named distribution rather than the unversioned Ubuntu default, which may install a newer release with different dependencies. The original build environment used Ubuntu 20.04; these instructions use Ubuntu 22.04 with GCC 10, so a complete build on this host still needs verification.

### 2. Install dependencies and get the source

Run all remaining build commands in the **Ubuntu WSL terminal**, not PowerShell:

```bash
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo apt-get update
sudo apt-get install -y \
  gcc-10 g++-10 make git unzip wget bison flex linux-libc-dev linux-libc-dev-arm64-cross \
  xz-utils libsdl2-dev libsdl2-mixer-dev libfreeimage-dev libfreetype6-dev libcurl4-openssl-dev \
  rapidjson-dev libasound2-dev libgl1-mesa-dev build-essential libboost-all-dev cmake fonts-droid-fallback \
  libvlc-dev libvlccore-dev vlc-bin texinfo premake4 golang libssl-dev curl patchelf \
  xmlstarlet patchutils gawk gperf xfonts-utils default-jre python-is-python3 xsltproc libjson-perl \
  libxml-parser-perl lzop libncurses5-dev device-tree-compiler u-boot-tools rsync p7zip unrar \
  libparse-yapp-perl zip binutils-aarch64-linux-gnu dos2unix p7zip-full libvpx-dev bsdmainutils bc meson rdfind
mkdir -p ~/src ~/.cache
cd ~/src
git -c core.autocrlf=false clone https://github.com/coreylad/AmberELEC.git AmberELEC
cd ~/src/AmberELEC
df -h .
free -h
gcc-10 --version
go version
```

Keep the checkout and build files under `~/src/AmberELEC`, not `/mnt/c`, OneDrive, or another Windows-mounted folder: the build needs Linux permissions, symlinks, and filesystem behavior. If you already cloned the fork inside WSL, use that checkout and select the branch containing the changes you want to build. Run `git branch --show-current` and `git log -1 --oneline` to confirm the source revision.

Stop if dependency installation fails. These commands use `apt-get`, the scripting interface, rather than `apt`; they do not run a system-wide upgrade or automatic package removal. Package downloads still require working Ubuntu repositories and a network connection. Ubuntu 22.04 supplies Go 1.18, satisfying the build's Go 1.17-or-newer requirement without an additional Go repository.

Verify the available disk space and memory with the commands above. Do not run the build as root or with `sudo make`.

### 3. Build the R36S image

From `~/src/AmberELEC`, run these commands in order and stop if any command fails:

```bash
export LOCAL_CC=/usr/bin/gcc-10
export LOCAL_CXX=/usr/bin/g++-10
export CONCURRENCY_MAKE_LEVEL=4
export THREADCOUNT=4
make toolchain-RK3326
make R36S
```

The compiler variables select GCC 10 without changing Ubuntu's default compiler. The RK3326 base toolchain must be built before the R36S image. Keep the WSL terminal open and prevent Windows from sleeping during the build.

If compilation is killed due to insufficient memory, lower both `CONCURRENCY_MAKE_LEVEL` and `THREADCOUNT` (for example, to `2`) and rerun the failed make command. Keep the source at the same absolute Linux path between builds; do not clean before every retry, since that discards reusable device build files.

### 4. Copy and flash the image

The compressed image is written to `~/src/AmberELEC/release/aarch64/R36S/`. Check the output and, if your flashing tool requires a plain `.img`, decompress it while keeping the original:

```bash
ls -lh release/aarch64/R36S/*.img.gz
gzip -dk release/aarch64/R36S/*.img.gz
explorer.exe .
```

In the Explorer window, navigate to `release\aarch64\R36S` and copy the `.img` to a Windows folder, such as Downloads. Flash it to the device's firmware microSD card using a Windows image writer such as [balenaEtcher](https://etcher.balena.io/). Flashing erases the selected card; verify the target carefully. Do not flash the update `.tar` file as a disk image. Follow the [installation instructions](https://amberelec.org/installation#overview) for first boot.

Local development images are unstable and intended for testing.
