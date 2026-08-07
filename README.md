# AlphaDroid Android 13 GSI for Huawei nova 3 (PAR)

## What this repository implements

The reproducible source-patch and release home for a personal AlphaDroid 1.10 /
TrebleDroid Android 13 GSI on Huawei nova 3 (`PAR`). It contains the upstream
integration, PAR-specific changes, and release tooling, not a copy of the
Android source tree.

TurboAdapter and all other proprietary inputs are excluded. The required files
are extracted from the published
[AlphaDroid 1.7 arm64 bvN vanilla image](https://sourceforge.net/projects/alphadroid-gsi/files/2023.07.07/AlphaDroid-v1.7.0-arm64_bvN-20230707-vanilla.img.xz/download).

## Upstream source base

- AlphaDroid 1.10 provides the ROM source base.
- TrebleDroid `ci-20230706` provides the GSI compatibility base. Some
  TrebleDroid repositories are pinned directly in `manifest/locked.xml`; its
  official developer patch bundle is applied to AlphaDroid-owned platform
  repositories that cannot simply be replaced by TrebleDroid forks.
- The TrebleDroid compatibility set is upstream work, not a PAR-specific
  addition. Its original authors are recorded in `ATTRIBUTION.md`.
- CalyxOS provides the Chromium and Trichrome WebView components integrated by
  this release.

## Disclaimer

This is a personal project shared as-is. Flashing custom images can cause data
loss, boot failure, or a bricked device. You accept all risk and responsibility
for flashing and recovery. No warranty, updates, porting, or device-recovery
support is provided. If you need different behavior, use the published source
and build instructions to compile it yourself.

## Compatibility

- Device: Huawei nova 3 (`PAR`).
- Verified stock firmware base: EMUI `9.0.0.187`.
- An EMUI 9 base is required; other major base versions are likely not to boot.

If hardware video decoding causes freezes or restarts with an unpatched kernel,
use the companion release from
[android_kernel_huawei_par_sukisu_patches](https://github.com/yukino1111/android_kernel_huawei_par_sukisu_patches).

## Build

Sync the revisions in `manifest/locked.xml`, download and decompress the
reference image linked above, then run:

```bash
PATCH_REPO=/path/to/this-repo
"$PATCH_REPO/scripts/apply.sh" /path/to/alphadroid
"$PATCH_REPO/scripts/extract-proprietary.sh" /path/to/alphadroid-1.7-system.img /path/to/alphadroid
cd /path/to/alphadroid
source build/envsetup.sh
lunch treble_arm64_bvN-userdebug
make systemimage -j"$(nproc)"
```

Provide signing keys and optional browser prebuilts outside this repository.

## Installation

Back up the stock partitions and make sure the bootloader is unlocked before
proceeding.

Use stock recovery to wipe `data` and `cache`, or use TWRP to perform a Factory
Reset. Decompress the downloaded `.img.xz`, enter Fastboot mode, then flash
the resulting `.img` to the `system` partition:

```bash
xz -d SYSTEM.img.xz
fastboot flash system SYSTEM.img
fastboot reboot
```

## License

Original scripts and documentation use Apache-2.0. Each patch retains the
license and authorship of its upstream project; see
[`ATTRIBUTION.md`](ATTRIBUTION.md) and [`LICENSES.md`](LICENSES.md).

## Acknowledgements

- [Android Open Source Project](https://source.android.com/) and
  [LineageOS](https://github.com/LineageOS) provide the Android platform base.
- [AlphaDroid Project](https://github.com/AlphaDroid-Project) provides the ROM
  base used by this patch set.
- [TrebleDroid](https://github.com/TrebleDroid) and Pierre-Hugues Husson's
  [PHH-Treble](https://github.com/phhusson/treble_experimentations) provide the
  GSI and device-compatibility foundation.
- [CalyxOS](https://gitlab.com/CalyxOS) provides the Chromium browser and
  Trichrome WebView used by the release build.
