# Build and release

## Inputs

- Android checkout at every revision in `manifest/locked.xml`;
- patches listed in `patches/series.tsv`;
- external release/AVB keys under `$HOME/android-keys/par`;
- pinned Calyx Chromium/Trichrome prebuilts outside the source tree;
- the companion PAR workspace build and packaging scripts.

The APK prebuilts and private keys are intentionally not stored in this
repository.

## Apply

```bash
scripts/apply.sh /path/to/alphadroid
```

The script checks every project HEAD against its pinned base revision. A patch
that is already present is skipped only after a successful reverse-apply check.

## Build and package

From the companion PAR workspace:

```bash
JOBS="$(nproc)" scripts/build_par_rom_docker.sh
scripts/check_par_build.sh rom
scripts/package_par_rom_images.sh
```

The first command builds `treble_arm64_bvN-userdebug`. The packaging command
then creates two sparse ext4 images from the same successful out directory:

- a generic arm64 `bvN` GSI;
- a PAR-AL00 variant whose system/product/system_ext/system_dlkm identity
  properties match Huawei nova 3.

The PAR variant changes identity properties only. It does not include a second
source tree, vendor partition, kernel or boot image.

## Release checks

- build status is `success` and `system.img` is non-empty;
- both images pass `avbtool info_image`;
- ext4 metadata passes a read-only `e2fsck` check;
- generic and PAR fingerprints match their intended targets;
- Chromium, Trichrome Library and WebView packages have the pinned versions;
- no `OMX.hisi.video.decoder.*` filtering code remains in `frameworks/av`;
- image names, byte sizes and SHA-256 values are recorded alongside the
  release artifacts.

Static image checks do not replace a full PAR-AL00 flash/boot/playback test.
