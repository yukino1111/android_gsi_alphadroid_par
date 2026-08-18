# AlphaDroid Android 13 GSI for Huawei nova 3 (PAR)

## What this repository implements

The reproducible source-patch and release home for a personal AlphaDroid 1.10 /
TrebleDroid Android 13 GSI on Huawei nova 3 (`PAR`). It contains the upstream
integration, PAR-specific changes, and release tooling, not a copy of the
Android source tree.

Proprietary release inputs are excluded. The former Google TurboAdapter and its
PowerStats provider library were removed because Android 13 rejected the APK's
legacy signature and neither copy of the library was loaded.

On Huawei vendor images, the framework asynchronously emits the supported
UniPerf touch, launch, scroll, fling, window, rotation, screen-on, and
fingerprint events. The bridge is device-gated and rate-limited, and its vendor
HIDL access is covered by narrowly scoped SELinux policy. It remains dormant
unless the independently distributed
[PAR Kirin 970 Scheduler](https://github.com/yukino1111/android_module_par_kirin970_scheduler)
verifies and enables a compatible systemless policy.

The current patch set also normalizes legacy Health HAL capacity units, prevents
low-power fused requests from falling back to GPS when no network provider is
available, scopes Launcher shake detection to the visible overview lifecycle,
and makes Telephony the single AP-side owner of Huawei NCFG writes.

## Upstream source base

- AlphaDroid 1.10 provides the ROM source base.
- TrebleDroid `ci-20230905` provides the GSI compatibility base. Some
  TrebleDroid repositories are pinned directly in `manifest/locked.xml`; its
  official developer patch bundle is applied to AlphaDroid-owned platform
  repositories that cannot simply be replaced by TrebleDroid forks.
- The TrebleDroid compatibility set is upstream work, not a PAR-specific
  addition. Its original authors are recorded in `ATTRIBUTION.md`.
- Cromite provides the Chromium and System WebView components integrated by
  this release. Version `147.0.7727.56` is pinned because newer 148/151 builds
  fail to initialize Chromium's GPU path on the nova 3 Mali-G72 stack.

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

## Known limitations

Huawei's `charge_counter` does not represent Android's expected remaining
coulomb count. Learned full-charge capacity is corrected, but BatteryStats may
still retain an implausibly small estimated-capacity value; this affects mAh
accounting, not the displayed battery percentage. Long-uptime wired ADB
stability also remains under observation.

## Build

Sync the revisions in `manifest/locked.xml`, then run:

```bash
PATCH_REPO=/path/to/this-repo
"$PATCH_REPO/scripts/apply.sh" /path/to/alphadroid
cd /path/to/alphadroid
source build/envsetup.sh
lunch treble_arm64_bvN-userdebug
make systemimage -j"$(nproc)"
```

Provide signing keys and release-only prebuilts outside this repository. Exact
Cromite release inputs are documented in [`PREBUILTS.md`](PREBUILTS.md);
the APKs themselves are not stored here.

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
- [Cromite](https://github.com/uazo/cromite) provides the Chromium browser and
  System WebView used by the release build.
