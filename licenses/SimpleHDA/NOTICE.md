<!--
  NOTICE.md
  SimpleHDA

  Created by laobamac on 2026/8/20.
  Copyright © 2026 laobamac. All rights reserved.
-->
# Third-party components

Copyright © 2026 laobamac. All rights reserved. Third-party components retain their own licenses.

- Apple's XNU kxld sources retain their Apple Public Source License headers. The build adapts these sources for the kernel SDK; packages include `xnu-APPLE_LICENSE`.
- Lilu's plugin bootstrap retains its original BSD license and copyright. Packages include `Lilu-LICENSE.txt`.
- MacKernelSDK and the SDK headers retain their original licenses and copyright.
- `Resources/AppleHDA.kext` contains original AppleHDA 600.2 binaries, resources, translations and the signed legacy HAL plug-in from macOS 15.8 KDK 24H23. These remain Apple's proprietary components, subject to Apple's applicable terms.

Dependency revisions are pinned in `VendorVersions.json`. Original AppleHDA file hashes are recorded in `Resources/AppleHDA.json`; the build verifies them before generating the embedded payload.
