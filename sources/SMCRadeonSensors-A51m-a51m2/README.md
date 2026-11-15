# A51m Navi telemetry source snapshot

Source for the packaged A51m telemetry integration. The
Release artifact matches the deployed/packaged executable byte for
byte. This does not establish whole-file reproducibility from the snapshot
with a different toolchain. The original source base is d0f3da8 in
https://github.com/ChefKissInc/SMCRadeonSensors ; this snapshot includes
A51m-specific telemetry changes. No fan-control changes or periodic
recovery daemon are introduced. Preserve the accompanying LICENSE.
