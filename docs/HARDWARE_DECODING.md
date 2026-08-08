# Huawei hardware video decoding

## Kernel and system must be paired

This ROM patch set deliberately exposes the stock Huawei
`OMX.hisi.video.decoder.*` components. It must be paired with a Kirin 970 kernel
containing `0002-kirin970-vdec-keep-protected-smr-in-secure-world.patch` from the
companion `android_kernel_huawei_kirin970_sukisu_patches` repository.

Without that kernel fix, a decoder request can reach `SCD_PROC`, write the
protected `SMMU_SMRx_P` bank from normal Linux, trigger a NoC permission fault
and reset the device. The earlier userspace workaround removed Huawei decoders
from `MediaCodecList`; it is intentionally absent from the current patch set.

## Expected runtime path

```text
app / WebView / browser
  -> MediaCodec
  -> OMX.hisi.video.decoder.avc (or another Huawei decoder)
  -> /dev/hi_vdec ioctl
  -> fixed Kirin 970 VDEC driver
```

The fix does not emulate Android 9 APIs and does not replace Huawei OMX blobs.
It corrects the kernel-side protected-register access while preserving the
existing OMX/ioctl ABI.

## Validation checklist

After installing both images:

1. Confirm the clean kernel contains no temporary `VDECDBG` instrumentation.
2. Play AVC/H.264 video in a framework app and Chromium/WebView.
3. Confirm logcat selects `OMX.hisi.video.decoder.avc` rather than a software
   decoder.
4. Repeat seek, pause/resume and multiple playback sessions.
5. Check for VDEC, IOMMU, SMMU, NoC, watchdog and blackbox errors.

The current kernel fix was validated on PAR-AL00 with the real Huawei AVC OMX
decoder before the userspace blacklist was removed from this release source.
