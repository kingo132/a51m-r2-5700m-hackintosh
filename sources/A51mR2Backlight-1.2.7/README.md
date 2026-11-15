# A51mR2Backlight 1.2.7 release source snapshot

Source for the A51mR2Backlight 1.2.7 release, including the native TG-cache
module and kernel-safe compiler configuration. The project excludes unrelated
display-policy and target-observation modules. Legacy global-rounding and
panel-profile switches are not enabled in the release configuration.

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

Distributed binary hashes and platform limitations are documented at the
repository root. Build outputs may vary with the toolchain. Original project and license:
https://github.com/kingo132/A51mR2Backlight.
