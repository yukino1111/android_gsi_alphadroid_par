# Release-only prebuilts

Large APKs, proprietary inputs, and private signing keys stay outside this
repository. The product makefiles use optional includes, so the source patch
set remains buildable without these release-only components.

## Cromite 147

The PAR release uses the official arm64 assets from
[Cromite v147.0.7727.56](https://github.com/uazo/cromite/releases/tag/v147.0.7727.56-271900671db643de04aa9f909f0dcc3415c8b827).

| Asset | Package | Size | SHA-256 |
| --- | --- | ---: | --- |
| `arm64_VanillaChromium.apk` | `org.chromium.chrome` | 277236931 | `a71d01ca76ded6d682ba3ab8721e383cbda954412db7555921e79595bc36f635` |
| `arm64_SystemWebView.apk` | `com.android.webview` | 293918528 | `1e8f1cae9987e9b376874c64cc32e5eb5fc13ec171936de301c99161bc84dd6a` |

Both APKs remain signed by their upstream publisher. The browser asset is
installed verbatim because Cromite intentionally compresses its crashpad JNI
library.
