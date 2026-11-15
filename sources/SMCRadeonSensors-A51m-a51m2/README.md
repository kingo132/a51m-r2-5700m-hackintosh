# A51m Navi telemetry source

Source for the packaged A51m telemetry integration in SMCRadeonSensors 2.4.0.
It extends the upstream base `d0f3da8` with A51m-specific telemetry handling.
The integration does not provide fan control or a resident recovery service.

Upstream: https://github.com/ChefKissInc/SMCRadeonSensors

Build with the project's matching Lilu/VirtualSMC SDK and MacKernelSDK dependencies.
Distributed binaries and sources are identified by SHA-256 in the root release
manifest. Build outputs may vary with the toolchain. Preserve the accompanying
LICENSE when redistributing the source or binary.
