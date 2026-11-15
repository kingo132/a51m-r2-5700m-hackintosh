# A51mR2Backlight 1.2.7 release source snapshot

Implementation files match the retained source snapshot for the deployed
1.2.7 binary. This separate snapshot leaves the original development checkout
and its pending review untouched. It excludes later display-policy code-page
and target-observation modules.

The Xcode project is reconstructed from that checkout: only the existing TG
module is added, kernel-safe TG compiler flags are retained, the later DPC
module is excluded and MODULE_VERSION is pinned to 1.2.7. The release config
does not enable the old global rounding or panel-profile test switches.

Build prerequisites: Xcode, the Lilu developer headers/bundle and MacKernelSDK.
Use dependency versions recorded in the root release manifest. Place local
`Lilu.kext` and `MacKernelSDK` links in this directory; they are ignored by Git.

```sh
xcodebuild -project A51mR2Backlight.xcodeproj -configuration Release \
  -target A51mR2Backlight ARCHS=x86_64 ONLY_ACTIVE_ARCH=YES \
  CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO build
```

Run the native TG policy/lifecycle test against a private local copy of the
matching Apple framebuffer driver; do not upload that driver or live dumps:

```sh
clang++ -std=c++17 -Wall -Wextra -Werror -I A51mR2Backlight \
  Tests/tg_cache_test.cpp -o /tmp/a51m-tg-release-test
/tmp/a51m-tg-release-test /path/to/AMDRadeonX6000Framebuffer
```

Build success is not byte-for-byte reproducibility or full sleep/wake
acceptance. Packaged binary hashes and unresolved issues are documented at
the repository root. Original project and license:
https://github.com/kingo132/A51mR2Backlight.
