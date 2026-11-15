# Retained A51m VirtualSMC source overlay

This source is retained from the a51m7 deployment snapshot. It includes the
battery and Dell sensor changes used by the packaged reference EFI. The
retained battery deployment artifact matches the packaged executable byte
for byte. Use the upstream/fork VirtualSMC build layout and matching Lilu
SDK/MacKernelSDK dependencies; no SDK binaries are vendored here. The
release manifest identifies deployed artifacts, not a claim that a build
with another Xcode version produces an identical complete binary.

Project: https://github.com/kingo132/VirtualSMC

Private firmware dumps, adapter identifiers and runtime captures are excluded.
