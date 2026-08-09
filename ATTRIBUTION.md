# Source attribution

This repository packages changes from several upstream Android projects. A
commit that imports or rebases a patch does not transfer authorship to the
repository maintainer.

## TrebleDroid compatibility patches

The following aggregate patches are required to reproduce the TrebleDroid
`ci-20230706` compatibility base used by this release. They were compared with
the official `patches-for-developers.zip` bundle kept with the build source.
The original `From:` authors in that bundle are credited below.

| Aggregate patch | Original patch authors |
| --- | --- |
| `bionic.patch` | Pierre-Hugues Husson |
| `bootable_recovery.patch` | Pierre-Hugues Husson |
| `build_make.patch` | Alberto Ponces, Andy CrossGate Yan, sooti |
| `external_selinux.patch` | Pierre-Hugues Husson, ponces |
| `frameworks_av.patch` | Alberto Ponces, Emilian Peev, Peter Cai, Pierre-Hugues Husson, ponces |
| `frameworks_base.patch` | Alberto Ponces, Andy CrossGate Yan, Arne Coucheron, Danny Lin, ItsLynix, Peter Cai, Pierre-Hugues Husson, Raphael Mounier |
| `frameworks_libs_net.patch` | Pierre-Hugues Husson |
| `frameworks_native.patch` | Andy CrossGate Yan, Pierre-Hugues Husson |
| `frameworks_opt_telephony.patch` | Artem Borisov, Christian Hoffmann, corneranchu, ExactExampl, ironydelerium, LuK1337, Peter Cai, Pierre-Hugues Husson, Raphael Mounier |
| `hardware_interfaces.patch` | Pierre-Hugues Husson |
| `packages_apps_Settings.patch` | Pierre-Hugues Husson |
| `packages_modules_Bluetooth.patch` | Alberto Ponces, Andreas Schneider, Peter Cai, Pierre-Hugues Husson, tzu-hsien.huang |
| `system_bpf.patch` | Andy CrossGate Yan, Pierre-Hugues Husson |
| `system_core.patch` | Alberto Ponces, Isaac Chen, Pierre-Hugues Husson, Raphael Mounier |
| `system_extras.patch` | Luca Stefani |
| `system_linkerconfig.patch` | Pierre-Hugues Husson |
| `system_netd.patch` | ChonDoit, Pierre-Hugues Husson |
| `system_nfc.patch` | Pierre-Hugues Husson |
| `system_vold.patch` | Pierre-Hugues Husson |

`build_make.patch`, `external_selinux.patch`, `frameworks_base.patch`,
`frameworks_native.patch`, and `packages_apps_Settings.patch` also contain
PAR/release-specific follow-up changes maintained by yukino1111. The
project-level aggregate format cannot preserve the original per-commit
metadata, so the upstream bundle remains the authoritative record for
individual TrebleDroid commits.

## PAR and release integration

The remaining aggregate patches are local build, product, or PAR integration
deltas maintained by yukino1111 against the exact revisions in
`patches/series.tsv`:

- `build_soong.patch`
- `device_lineage_sepolicy.patch`
- `device_phh_treble.patch`
- `external_fastrpc.patch`
- `external_libncurses.patch`
- `packages_apps_Eleven.patch`
- `packages_apps_WallpaperPicker2.patch`
- `packages_modules_Permission.patch`
- `system_security.patch`
- `vendor_lineage.patch`

These deltas remain subject to the copyright and license of the files and
projects they modify. AlphaDroid, LineageOS, AOSP, CalyxOS, and TrebleDroid
contributors retain authorship of their respective upstream code.
