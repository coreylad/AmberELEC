# R36S Builds

## Local Windows build (recommended for this fork)

Build the image on your own PC using [the Windows WSL 2 guide](../README.md#building-on-windows-with-wsl-2).
It covers WSL and Docker setup, building the RK3326 toolchain and R36S image,
and copying the resulting `.img` to Windows for flashing. No GitHub Enterprise
subscription or Actions runner is needed. Output is saved locally under
`release/aarch64/R36S/`.

## Optional cloud build

[build-r36s.yaml](build-r36s.yaml) is manual-only and does not run on pushes.
Use **Actions → build-r36s → Run workflow** only if you already have access to
a suitably provisioned larger runner.
It builds the RK3326 toolchain followed by the R36S image in a Docker container
built from this repository's Dockerfile. No prepublished container or self-hosted
`main` runner is required.

## Cloud runner setup

AmberELEC recommends at least 4 CPU cores, 16 GB RAM, and 200 GB free SSD space.
Standard free GitHub-hosted runners do not meet these requirements. This workflow
uses a **larger GitHub-hosted Linux x64 runner** named `ubuntu-22.04-16core`.
That name is a configured runner name, not a standard GitHub runner label.

Before building, an administrator must provision that runner under the GitHub
organization's **Settings → Actions → Runners → New GitHub-hosted runner**, choose
Ubuntu 22.04 x64 with sufficient resources, and grant this repository access to its
runner group. Larger runners require an eligible organization plan and are billed
separately; simply changing the workflow does not provision a runner.
See [GitHub's larger runner documentation](https://docs.github.com/en/actions/using-github-hosted-runners/using-larger-runners).

For manual runs, the **runner** input accepts an alternative configured runner
name. The default is `ubuntu-22.04-16core`. If a job stays queued, check that the
runner exists, is available, and its runner group allows this repository.
The workflow checks available disk space and memory before starting compilation.

Each run is a clean build with a six-hour job timeout. There is no separate
Docker publishing, cleanup, multi-device, or release workflow.

## Download the image

Open a successful workflow run and download **AmberELEC-R36S-&lt;commit SHA&gt;**
from its **Artifacts** section. Extract the ZIP to obtain the uncompressed
`.img` ready to flash to a microSD card. Artifacts are retained for 30 days.
The build normally emits `.img.gz`; the workflow decompresses it before uploading.

These development images are unstable and intended for testing.
