# Release verification — 2026.11.15

- Matched the two packaged KEXTs byte-for-byte to the deployed copies and
  recorded every packaged component/source SHA-256 in the release manifest.
- Rebuilt the retained backlight 1.2.7 source with the reconstructed Release
  project. Build succeeded. Its `__TEXT,__text` and `__TEXT,__cstring` sections
  match the deployed binary exactly; the complete files differ, including
  `__TEXT,__const`. Do not claim whole-file reproducibility.
- Ran the TG policy/lifecycle/native-bytecode tests against the installed
  framebuffer. Synthetic TG IDs, stream replacement, stale/nested callbacks,
  concurrent writes, registry-ID reuse and fail-closed guards passed. This
  test uses owned fixtures, not live kernel/hardware access.
- Ran the battery fork tests with UndefinedBehaviorSanitizer: time boundaries,
  independent flags, unchanged current, real updater/observer methods, bounded
  ring, reply mutation, request reuse and decoder negative cases passed.
- Matching OpenCore 1.0.7 `ocvalidate` reports no issues in the sanitized
  release config. KEXT order, release flags and artifact versions are checked
  by `scripts/check_release.py`.
- AirPlay's read-only preflight accepts the installed MediaToolbox and
  VideoToolbox image identities/code spans. No preference was changed by this
  preflight. Earlier two real peer-Mac connect/disconnect cycles remain the
  functional acceptance scope.
- Eight privacy negative-control test methods pass. A separate local scan of
  the exact staged new/modified blobs used private identity values and common
  encodings without printing them. Raw diagnostic archives, firmware-license
  tables and populated public identity fields are excluded.

These are local release checks. CI results must be read from the published
commit's actual workflow run. Neither test success nor packaging establishes
full wake-brightness, permanent Universal Control reconnection, all WindowServer
timeouts or long-uptime stability; those stay open in [TODO.md](../TODO.md).

No live EFI, BIOS, system cache or reboot state is changed by these checks.
