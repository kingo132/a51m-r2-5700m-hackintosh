# RX 5700M HDMI audio and DDC/CI

Reading order: the opening 1.2.15 acceptance is the latest recorded checkpoint.
All subsequent implementation, staging, running-version and pending-status
statements describe their historical checkpoints, not the current system.
The public EFI still packages backlight 1.2.7; this document publishes research
and local acceptance history, not the newer HDMI driver binary.

Current1.2.15 acceptance: connected VG280K HDMI detection and actual
BetterDisplay readback pass. Brightness/contrast/full415-byte report succeed;
17 attributable valid replies have0 bus/frame errors. User screenshot
confirms all four DDC statuses green. Physical miniDP/reconnect/wake/uptime
and periodic-read configuration checks remain open. See backlight project
`Docs/HDMI_ACCEPTANCE_20261116.md`. Earlier states below are historical.

Latest reviewed deployment:1.2.15 adds a qualified-HDMI minimum10ms native
response wait, preserving longer minima and restoring caller metadata. Native
sequencing/restoration/exclusion and build checks pass. Fresh full local/ESP
incremental rollback and290-file checks confirm only this KEXT executable/Info
changed. Running1.2.14 until user restart; actual new App/GUI/miniDP/wake
acceptance is pending. Existing1.2.14 correct-wait Type2 acceptance is retained.
Earlier proposal/staging descriptions below are historical.

Reviewed1.2.14 shared-buffer fix is now implemented and staged with verified
full local/ESP incremental rollback. All290 active EFI files were checked;
only this KEXT executable/Info changed. Actual kernel Type2/App/miniDP
acceptance awaits user restart. No automatic reboot or commit occurred.
The earlier1.2.13 failure/prototype checkpoints below are historical.

Latest1.2.13 boot: actual HDMI identification succeeds, but the patch rereads
its command after the native DAL clears a shared send/reply buffer. Current
IOGraphics native code confirms this aliasing. All9 attributed app queries
pass through without repair. The unchanged classifier fails29 owned alias
cases; retaining the pre-send validated command passes29, with28 descriptor/
snapshot negatives rejected. The exact two-file fix is proposed and unapplied;
no new KEXT/EFI change or live Type2 success is claimed. See the backlight
project's `Docs/HDMI_SHARED_BUFFER_20261116.md`. Earlier checkpoints below
are historical.

## Latest post-boot correction

Running1.2.12 now passes code/ABI admission and installs HDMI/TG hooks.
Actual BetterDisplay brightness requests pass the profile but are rejected
by the wrong signal classifier: HDMI is observed4, while code and old
fixtures used16 (RGB). The old fixture premise is withdrawn. Capability
queries also fall outside the original three-feature reader. Local1.2.13
corrects signal matching and proposes standard GetVCP plus bounded37/38-byte
capability replies, preserving native caller clamping and type2 request
semantics. Real Simple/type1 transport validates the production parser with
six controls and a complete415-byte report; it does not accept new kernel
hooks. Builds/native replay pass. After explicit expanded-scope review,
1.2.13 is staged with fresh full local/ESP incremental rollback. All290 EFI
files checked; only this KEXT executable/Info changed. Running1.2.12 still
fails DDC until restart; new Type2/app/miniDP/wake acceptance remains open.
The upgrade/staging checkpoint below is historical.


## Current OS-upgrade compatibility checkpoint

The user upgraded from26.7.1/25G241 to26.7.3/25G342. Backlight1.2.11 loaded,
but HDMI Ready=false/driver-contract-mismatch and TG HooksReady=false/
unsupported-framebuffer-uuid. Neither guard installs its hooks. The driver
UUID changed fromC3FA8B38-0702-3FCD-9878-C8FD05A7A724 to
F527F501-CD46-34D0-AEB3-C8E5C8ADF2C8. The complete executable/string/constant
sections are byte-identical;32 changed bytes lie in header metadata.

Local1.2.12 replaces UUID-only build admission with bounded per-feature
full-code/layout verification:12 HDMI and8 TG spans plus existing symbols,
real PCI, virtual targets, native request scoping and short-hook guards.
Unique nonzero identity metadata remains required. It supports unchanged
contracts across build identities without a new UUID-list edit; changed
relevant implementations/interfaces or unsupported kernel families still stop.
This is not a promise of all future private-driver compatibility.

53 owned compatibility cases, native topology replay, both-version TG
fixtures and Release/Debug builds pass. The user approved the reviewed candidate;1.2.12 is staged after a fresh full
local backup and ESP incremental rollback. Only the two KEXT files changed;
config/other payloads remain intact. The running kernel stays1.2.11 until
user restart. Actual type2 hardware readback still fails
on the running system while type1 reads13/100. No app/EFI settings changed.
The correction record is `Docs/FRAMEBUFFER_UPDATE_COMPATIBILITY_20261116.md`
in the backlight checkout. Earlier staging states below are historical.

## Post-boot qualification failure and staged correction

The 1.2.10 HDMI-only build loaded with the expected UUID and argument, but
a controlled single HDMI type-2 query incremented notHdmi/pass-through while
armed/repaired stayed zero. It still failed; type1 at10/50ms read13/100.
Native diagnostics confirm a connected HDMI link at dynamic index2 and
connector12:1:3. The physical monitor can respond to DDC.

The handler conflated the upper AmdLink wrapper and the DAL dc_link object:
it read the wrong layout's signal offset and compared unequal object types'
pointers. The 1.2.11 correction follows the authenticated native dynamic
index/helper/DAL link-array chain, then scopes the selected dc_link and engine.
Full owned native-entry tests now cover distinct objects and indices0/1/2;
previous supplied-eligibility tests missed this integration boundary.

The isolated1.2.11 build is staged with fresh full local/incremental ESP
rollback, changing only the KEXT's two files. Config and all other payloads
are unchanged. Running1.2.10 remains until user restart; actual success is
not claimed. Fixed brightness/volume/mute queries are in scope; capabilities
strings and a fully successful BetterDisplay report are not yet established.
See the backlight checkout's `Docs/HDMI_TYPE2_POSTBOOT_20261116.md` for the
exact build identity, qualification evidence, tests and rollback. Older
checkpoints below are historical, not current acceptance results.

## Current implementation checkpoint, 2026-11-16

The user authorized local KEXT implementation after reviewing the type-2
diagnosis. A51mR2Backlight local 1.2.10 now contains a default-off
`-a51hdmitype2` fixed-reply candidate. **Its isolated HDMI-only variant is now
staged in the active EFI, awaiting user restart; it is not loaded.**
The running backlight remains 1.2.7; no system restart or cache operation was
performed. The staged build preserves the authenticated archived 1.2.7
brightness/TG baseline and excludes other local brightness/display-policy work.
Two full EFI backups are verified; only the backlight bundle and single enable
argument changed. Exact identity/rollback are recorded in the backlight
checkout's `Docs/HDMI_TYPE2_DEPLOYMENT_20261116.md`.

The caller's request remains type 2 throughout. A qualified outer request
scope authenticates the actual supported GPU, existing framebuffer gate and
current ordinary-I2C HDMI link. The native DAL still sends once, waits, locks,
preclears and selects its type-2 leaf. Only the matched leaf uses the native
ordinary byte-reader primitive for one correct-address 11-byte response,
followed by frame/echo/checksum validation. Native errors and valid
unsupported-feature status are preserved. No polling, app cache or new
background service supplies values.

The scope is brightness 0x10, volume 0x62 and mute 0x8d GetVCP only.
Capabilities strings, SetVCP, DP/eDP/MST and unknown/nested requests keep
native behavior. Owned native-code tests verify type 2 remains selected,
native command/wait/lock/result ordering, malformed/error rejection and AUX
exclusion. Pure core tests include 24,000 concurrent requests and UBSan;
28 driver-contract cases and the Release build pass. These are not physical
bus or boot acceptance. Actual HDMI/app readback, hotplug/wake and miniDP
audio/DDC still require approved deployment and real acceptance.

The detailed current implementation and rollback are in the backlight
checkout's `Docs/HDMI_READBACK_PROPOSAL_20261116.md`. Historical experiments
below describe earlier, unlinked alternatives; in particular the type-2-to-1
request adapter is **superseded**, not the implemented current approach.

Status: HDMI audio and BetterDisplay brightness control passed a connected
session. The type-2 driver candidate is staged; actual readback acceptance
remains open. The earlier application-setting repair required no EFI change.
HDMI sound and DDC/CI must be checked separately. The miniDP path already
working does not establish that the HDMI audio pin and DDC channel are correct.

## Connected HDMI configuration repair, 2026-11-16

One active VG280K HDMI output was identified using its current framebuffer,
connector type `0x800`, actual port 2 and EDID identity. The same framebuffer
registry object previously served miniDP; an index is not a fixed connector.
No display mode, EDID, firmware or KEXT was changed.

Audio metadata is `00 01 03 00`, matching the existing NaviAudioFixup override.
CoreAudio exposes the monitor as its default 48 kHz stereo output; its valid
CTA data advertises two-channel LPCM. Native playback completed and the user
confirmed sound from the monitor. No new audio patch was needed for this
session. Hotplug/wake audio and the historical silent session remain separate.

Connected read-only Get VCP comparison:

| Reply transport | Delay | Observed result |
| --- | --- | --- |
| DDC/CI type 2 | 10 and 50 ms | Native request error `0xe00002bc`, no valid frame |
| Simple type 1 | 50 ms | Valid checksum/frame, brightness 38/100 |
| Simple type 1 | 10 ms, first attempt | API `kIOReturnBusy`; no completed transaction |

Three further 50 ms Simple reads all returned 38/100. The same native reader
returned volume 67/100 and mute value 2 (unmuted). Busy is distinct from a
monitor timing failure; increasing delay alone is not a proven DDC/CI repair.

The active HDMI display's **Allow DDC** setting in BetterDisplay was disabled.
After a verified private configuration backup and user review, only that
display's setting was enabled while the app was stopped, then it was reopened.
The working miniDP display's setting and global policies were kept.

BetterDisplay's normal brightness command passed 38 -> 39 -> 38. At every
stage three independent Simple Get VCP reads matched the physical monitor
value. Both app commands succeeded; no native recovery write was needed.
Volume stayed 67 and mute stayed 2. The setting is retained because the
approved functional test passed. Later passive observations saw physical 44
with app value 0.438, consistent with integer monitor rounding; no later
brightness was overwritten or attributed to a caller. Preference-file cached
control values can lag live app state.

Application brightness control is restored without a new KEXT, service or
system restart. Type-2 reads remain broken: BetterDisplay's direct Get VCP
still fails. Automatic hardware readback/synchronization, other controls and
reconnect/wake persistence remain unaccepted. An app-cached value is not a
successful hardware read. Driver capability/transport changes still require
separate review; none was deployed.

Configuration backups and raw identity/audio/query captures remain private.
Outline sync is pending: the existing entry returned a login page.

## Automatic readback proposal for review

### Fault ownership and the two native request types

An independent read-only IOKit client repeated the comparison after the app
configuration repair. Type2 failed at both10ms and50ms with native request
error0xe00002bc. Type1 returned checksum-valid brightness44/100 at both delays.
No BetterDisplay API or setter was involved. Thus BetterDisplay is not a
necessary condition for this failure; the failing AMD/HDMI native path is the
primary defect/compatibility boundary to investigate. This does not establish
one unique internal bus-level cause or every monitor/request combination.

Type1 (`kIOI2CSimpleTransactionType`) and type2
(`kIOI2CDDCciReplyTransactionType`) are Apple IOKit transaction types, not HDMI
versions or competing monitor-control standards. Both can carry the same DDC/CI
Get VCP query. Simple takes the requested reply byte count; the DDC/CI-specific
path handles the embedded reply length. The current AMD implementation's
address handling and two-part read sequence are distinct from the working
Simple reader.

BetterDisplay supports both types. Its authenticated selection code prefers
type2 when the advertised mask supports it; current HDMI advertises31. This
choice alone is not evidence of an app programming error. A successful app
fallback could mitigate the driver's failed path; it would not repair type2
itself. Likewise the proposed KEXT request redirection is a compatibility
adapter, not a completed repair of the type2 reader's internal implementation.

Other applications cannot be assumed immune:

- [MonitorControl Intel backend](https://github.com/MonitorControl/MonitorControl/blob/7cfe64500d19cbbcbf82121a91c826f658a403bd/MonitorControl/Support/IntelDDC.swift):
  accepts either type, defaults to advertised type2 before Simple; its
  constructor has an explicit type override. This is not a verified GUI option.
- [ddcctl backend](https://github.com/kfix/ddcctl/blob/06c7ab6eba5b1c903678f8113a92cef990acaf90/src/DDC.c):
  default detection also prefers type2; `TT_SIMPLE` is a build-time alternative.
- [Lunar public Intel C backend](https://github.com/alin23/Lunar/blob/06950e25747159c81f501a5e4477374abb1d779a/Lunar/DDC/DDC.c):
  has the same default preference and compile-time alternative. The installed
  commercial app/build and its selected backend were not examined on this host.

These source comparisons predict possible exposure to the same failed native
path; they are not whole-application live acceptance. A separate unmodified
MonitorControl backend harness failed target/ownership checks and its cleanup
assertion, producing no qualified result. It is not counted as an installed
MonitorControl failure or a successful hardware comparison. No GUI app was
installed, replaced or configured for this comparison.

The current local implementation replaces the fixed type-2 reply leaf while
retaining its request type; it supersedes the earlier request-entry conversion
proposal. Runtime GPU/gate qualification and route integration are implemented
but not live accepted. Only the three live-verified 11-byte GetVCP replies
(brightness, volume, mute) qualify; capabilities require separate validation.
The subsequent approved deployment changes only the backlight bundle and HDMI
enable argument; no new application setting changed for this implementation.
A separate **after-fix** private BetterDisplay export preserves the working
DDC setting; earlier before-fix exports remain rollback backups.

## Upstream audio repair already present

TechProgenitor reported a native HDMI audio repair in
[issue 26](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/26#issuecomment-5740637326).
His [NaviAudioFixup](https://github.com/TechProgenitor/NaviAudioFixup) overrides
the HDMI audio Pin NodeID using:

```text
naviaudio-patch-enable = OSData 01 00 00 00
naviaudio-port2-node   = OSData 03 00 00 00
```

These values and NaviAudioFixup 1.0.0 are already present in the live
configuration. The module is loaded, and the GPU's runtime properties have
the expected OSData types and values. Reinstalling the same plugin is not a
new repair.

The reviewed upstream tree is
`4882970ff2eec11284a1ddbbe8194f0735f74c16`; the implementation blob is
`889d27ee1cfb9e585dc23a5b6b091028f0ea42c9`:
[kern_naviaudio.cpp](https://github.com/TechProgenitor/NaviAudioFixup/blob/4882970ff2eec11284a1ddbbe8194f0735f74c16/NaviAudioFixup/kern_naviaudio.cpp).
The wrapper calls Apple's original `reportCapabilities_LinkInfo`, walks two
parents to the GPU, reads an OSNumber `port-number`, and changes only the
matching framebuffer's `audio-codec-info`. For port 2/node 3 the expected
bytes are `00 01 03 00`. The current service ancestry matches this lookup.

At the recorded checkpoint only the internal panel and miniDP were active.
The third framebuffer had port-number -1 and zero audio metadata. This is an
inactive output, not proof that the connected HDMI path ignored its override.
The current capture cannot decide whether the reported audio failure predates
this configuration or still occurs after it.

When HDMI is active, the decisive checks are the actual port-number and
audio-codec-info, the attached AppleGFXHDA endpoint, and the monitor's audio
capability data. If the metadata remains wrong, investigate the hook/lookup;
if it is already correct, inspect endpoint/pin/ELD rather than change the same
property again. The upstream Linux ELD method can independently verify the
connected monitor's codec pin. No NodeID was guessed for another output.

## Later upstream audio work: AudioFixup

Reviewing issue 27 adds a newer development that issue 26 alone did not cover.
TechProgenitor subsequently published
[DisplayChangeDelay](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/27#issuecomment-6256699884)
and then [AudioFixup](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/27#issuecomment-6334805912),
combining audio information overrides, display-handler delay and Realtek power
handling. This updates the earlier bounded search; NaviAudioFixup is not his
only later audio implementation.

The reviewed AudioFixup tree is `9b1b856cffb61e9e78b828a489ee101bf0e56b8c`.
Its [codec-info wrapper](https://github.com/TechProgenitor/AudioFixup/blob/9b1b856cffb61e9e78b828a489ee101bf0e56b8c/AudioFixup/kern_codecinfo.cpp)
acts at AppleGFXHDA/AppleHDAController's property-consumption point, rather than
only the AMD capability publisher. It reads the actual port number, walks to
the GPU, applies `audio-port#-info` or individual byte overrides, then calls the
original property reader. For the RX 5700M the author's later recommendation
is [port 2 / pin 3](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/27#issuecomment-6365415296).
If adopting that implementation after review, use the source-verified OSData
forms `audio-patch-enable = 01 00 00 00` and
`audio-port2-info = 00 01 03 00`; do not assume an integer example works for
all its individual enable/byte lookups.

Its [display-change wrapper](https://github.com/TechProgenitor/AudioFixup/blob/9b1b856cffb61e9e78b828a489ee101bf0e56b8c/AudioFixup/kern_displaychangedelay.cpp)
busy-waits with IODelay before IOAccelDisplayPipe's original display-change
handler. `displaychangedelay` is in microseconds, defaults to zero, and is
capped at one second. The author's successful 5 ms example concerned an RX
6950 XT audio endpoint disappearing after hotplug. He separately reported his
5700M audio remaining connected. That does not justify adding the same delay
to this machine without matching endpoint evidence.

Current loaded modules and EFI were rechecked: NaviAudioFixup 1.0.0,
AppleALC 1.9.8, SimpleHDA 1.0.1 and AppleGFXHDA 550.1 are present;
AudioFixup and DisplayChangeDelay are not installed/loaded. No double-hook
conflict from those new plugins is currently demonstrated. Their Realtek
AFG options are separate from the HDMI-only report and were not added.

The exact three upstream codec-override methods were also compiled against
owned registry/data objects. Nineteen cases passed, covering the original
getter, GPU ancestry, OSData enable flags, per-port/full-info precedence,
malformed values, integer overflow and property-write failure. These are
source-contract tests, not a loaded AudioFixup or a successful HDMI audio test.

The current AppleGFXHDA 550.1 consumer method is present with the exact symbol
used by AudioFixup. Its authenticated 244-byte body was executed against owned
registry/data objects in nine additional cases. The proposed four bytes
`00 01 03 00` are decoded as the expected native integer `0x00030100`.
An important limit emerged: this native getter returns success even for a
missing or wrong-type property, leaving its default output 10. Success alone
therefore proves neither a valid port number nor codec metadata. The earlier
upstream-source tests use an explicit original-getter mock; they are not proof
that missing properties return errors in the installed driver. Connected-port
validation must inspect the actual registry property and value as well.

The concrete audio decision is therefore: inspect the connected HDMI port's
metadata and codec endpoint. A demonstrated publisher/consumer timing mismatch
would justify reviewing migration to AudioFixup's consumer-side override,
replacing NaviAudioFixup rather than casually stacking both. An endpoint-ready
race would separately justify a measured delay. Neither change repairs the
DDC address defect, and neither has been deployed.

## No verified TechProgenitor DDC repair found

All 56 retrieved comments on issue 26 were reviewed, together with the
NaviAudioFixup implementation and repository searches. No successful HDMI
DDC/CI repair by TechProgenitor was located in those sources. Additional searches
and the reviewed later issue 27 audio work did not establish a DDC repair either. This is a bounded
search result, not a claim about every private experiment or future comment.
NaviAudioFixup changes audio metadata; it does not change I2C/DDC routing.

The latest reviewed [TechProgenitor comment](https://github.com/kingo132/a51m-r2-5700m-hackintosh/issues/26#issuecomment-6911371512)
reports occasional stutter before iPhone HDR playback when `CFG_LINK_FIXED_MAP`
is enabled. The author explicitly does not establish a relationship to GPU
completion timeouts. This is not a new HDMI audio/DDC repair. The current EFI
and live GPU property check show `CFG_LINK_BUILT_IN_MAP = 1` and no fixed-map
property; the nested ATY default dictionary is a different property layer.
It does not justify removing the same obsolete fixed-map property again or
declaring the remaining timeouts explained.

Current AMD framebuffer identity:

```text
AMDRadeonX6000Framebuffer CFBundleVersion 7.0.1 / short version 7.1.8
UUID C3FA8B38-0702-3FCD-9878-C8FD05A7A724
```

All three framebuffers publish an IOFramebufferI2CInterface. The inactive
third output advertises the driver's no-link defaults (bus type 2 and
transaction mask 31); these do not prove the capability of a connected HDMI
link. Exact native code confirms:

- `doI2CRequest` obtains the framebuffer's active link. A missing link returns
  `kIOReturnNoDevice` (0xe00002d7); otherwise it passes the link index to the
  service dispatch. Exact AmdLink vtable checks identify slot +0x218 as
  `getLinkIndex`, not `getDdcChannel` (the latter is +0x240). Calling the index
  a physical DDC channel would be incorrect. The downstream channel follows the selected link
  to its DDC pin. No mismatching channel has yet been observed on active HDMI. An audio pin number is a third identifier.
- `reportCapabilities_I2cInfo` uses the real link metadata when present. Its
  five table entries are transaction masks `[31,31,31,15,31]` and bus types
  `[2,2,2,1,2]`; absent-link defaults are 31/2. All these masks include simple
  and DDC/CI reply transactions. Do not infer that HDMI has no DDC merely from
  the absence of DisplayPort-native transaction support.
- The AGDC `convertToI2cStruct` helper accepts a restricted combined-read
  form. That helper is not the direct IOFramebuffer I2C dispatch path; its
  restrictions alone cannot diagnose failure of a normal DDC/CI application.

The disassembled bodies were read from the matching SystemKC after checking
the loaded UUID. No live kernel memory or DDC setting was written.

## Retained firmware connector map

The repository's 2021 VFCT disassembly contains a complete 59,392-byte Navi10
option ROM. Both the reconstructed VFCT checksum and the option-ROM checksum
pass. The AMD vendor/device identity is 1002:731f. Parsing its ATOM object
table revision 1.4 using the
[Linux definitions](https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/include/atomfirmware.h)
and [Linux record traversal](https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c)
gives:

| Path | Connector object | I2C record | HPD record |
| --- | --- | --- | --- |
| 0 | 0x3114 | 0x90, slave 0 | pin 1 |
| 1 | 0x3113 | 0x92, slave 0 | pin 3 |
| 2 | 0x310c | 0x91, slave 0 | pin 2 |

These firmware record values are not NaviAudioFixup's NodeIDs or necessarily
the same numbering as `port-number`. Reordering properties because the numbers
differ would be unjustified. The retained ROM SHA-256 is
`8aeac82604620cc1a37141d8a9471f79b49a04678c0a7f516d6c2dcc4f95e509`.
This is historical firmware evidence, not a fresh BIOS extraction. The normal
IORegistry platform query did not provide the current VFCT; current firmware
equivalence and actual HDMI transaction routing have not been established.

## Corrected AppleMCCSControl lead

The backlight bridge suppresses the Gibraltar and Cello probe methods, as
in the extracted WhateverGreen behavior. The installed AppleMCCSControl 1.17
personalities match these two classes to `IOACPIPlatformDevice` named
`backlight`. The external `AppleMCCSControlModule` personality matches
IOFramebuffer and is not routed by those two hooks. The initial suspicion
that the hooks disable every external DDC driver is unsupported and withdrawn.
No change to this suppression is justified by the HDMI report.

## Concrete next repair decision

No connector, audio-map or VBIOS change is currently justified. A concrete
native DDC/CI address-conversion candidate is documented below; it is local
and unlinked, with no connected-HDMI acceptance or deployment yet. The next connected-HDMI comparison must distinguish:

| Connected HDMI result | Repair direction |
| --- | --- |
| Active port's audio metadata is wrong | Correct the proven hook/property/port mismatch only |
| Metadata is correct but audio endpoint/pin data is wrong | Fix the endpoint/pin association using observed data |
| DDC Get VCP works through the matching interface | Correct application display/interface selection or supported transaction settings |
| Request open/send succeeds but request.result fails | Trace the active link's transaction/channel failure, keeping the two return values separate |
| Reply arrives but has invalid checksum/status/VCP | Resolve protocol/monitor behavior, not an audio-node property |

The [MonitorControl Intel implementation](https://github.com/MonitorControl/MonitorControl/blob/7cfe64500d19cbbcbf82121a91c826f658a403bd/MonitorControl/Support/IntelDDC.swift)
is a primary reference for Get VCP framing, separate send/request results and
reply validation. A read query sends protocol bytes but does not change the
monitor brightness. A future probe must bind to the actual output, log the
advertised transaction support, and avoid treating another monitor's success
as HDMI acceptance. No such live HDMI transaction was issued at this checkpoint.

### Initial split-read compatibility investigation

The native DAL route has now been followed beyond the framebuffer wrapper.
It validates the link index and dispatches HDMI requests separately from AUX.
Its non-DP rejection branch concerns transaction type 4 (DP-native access),
not ordinary DDC/CI. Treating that branch as a rejection of HDMI DDC would
have been incorrect.

The actual HDMI DDC/CI reply helper reads the first two reply bytes in one
lower-level submission, then the remaining length in another. Its complete
261-byte body has SHA-256
`70fcfb0886ac1cecb31ca5ab90b1a757bd4aee8a3a12159d2e8eb34110579307`.
An owned native-instruction test with mock hardware covers four cases:
continuing reply data, restarting reply data, first-read failure and second-read
failure. Restarting the response produces a corrupted assembled reply even
though the helper reports success. This is a protocol counterexample; neither
the actual bus STOP behavior nor this monitor's response behavior has been
proved. AUX also has a split-read path, so the existence of two submissions
alone does not prove the HDMI-only symptom.

Read-only file inspection of installed BetterDisplay 5.2.1 confirms that its
Intel backend prefers reply type 2 when the interface advertises that bit;
it falls back to type 1 when only simple replies are advertised. The actual
request builder reads that selected type. This establishes the relevant
application path, not a currently successful or failed HDMI transaction.
No BetterDisplay page, preference or executable was changed.

The next bounded comparison is prepared in the backlight project's
`Tools/probe_hdmi_ddc.py`. Default invocation reads registry metadata only.
With `--probe`, it requires one active HDMI framebuffer (native connector
type 0x800), the same display identity and one matching I2C interface. It sends
only Get VCP 0x10, with four combinations: reply types 2/1 and waits 10/50 ms.
There is no Set VCP, monitor power command or brightness setting. The native
request ABI and absolute-time conversion are checked; the owned query child
is limited to 20 seconds and partial progress is retained on failure. Ten
offline protocol/selection checks pass. On the current inactive-HDMI host,
the real `--probe` preflight refuses before sending a query.

| Comparison result | Specific change to review |
| --- | --- |
| Type 1 gives valid replies while type 2 fails at the same delay | Compare the confirmed native address-conversion defect below before forcing a reply-type fallback. Address repair and the separate split-read limitation must be distinguished by valid replies. No capability-mask patch is implemented or approved. |
| Both modes work only with the longer delay | Prefer the application's supported per-display response-wait setting, avoiding a new KEXT change. Verify the installed version's setting before applying it. |
| Both modes fail even with the longer delay | Do not apply a reply-mode workaround. Continue at the actual channel/physical transaction and monitor input. |
| Both modes work at the original delay | Investigate the app's output selection/detection state; do not claim a driver failure. |

The [vendor guide](https://betterdisplay.pro/guide/interface-reference/settings/displays/display/device-control/ddc/)
documents response-wait controls. It does not establish that the installed
version exposes a simple/DDC/CI reply-type preference. Ignore-checksum is not
an acceptable substitute for a valid reply and will not be enabled as a fix.

Private EDIDs, device identities, EFI configuration and raw logs remain outside
this document. Outline synchronization is pending. A narrow historical kernel
log query timed out; this is not evidence that audio hook errors were absent.


## Concrete native address-conversion defect and local candidate

Tracing past the split-read helper found a more direct defect. In the matching
native driver, the direct-I2C DDC/CI reply helper clears the low bit of the
IOI2CRequest address (`0x6f -> 0x6e`). The ordinary simple reader instead shifts
right by one (`0x6f -> 0x37`). Both pass the payload to the same hardware submit
path. Its native hardware encoder shifts the payload address left and inserts
the read bit. The resulting wire address is therefore `0xdd` for the DDC/CI
path, versus the correct `0x6f` for the ordinary reader. The intermediate native
submit/engine-selection/payload-loop instructions pass the payload unchanged;
this finding is not based solely on assuming a Linux structure layout.

The [Linux AMD hardware-I2C implementation](https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c)
independently documents this 7-bit payload contract. BetterDisplay's installed
Intel request builder and the cited MonitorControl implementation both use
standard API reply address `0x6f`.

A local candidate replaces `and r12b,0xfe` with `shr r12b,1; nop` in the native
reply reader. This is one four-byte instruction span, with three changed byte
values. Both existing reads, channel/speed selection, failure handling and
cleanup remain. The replacement does not change the AUX reader used by the
working miniDP output. The direct-I2C function itself is shared with other
non-AUX outputs, so it must not be described as globally HDMI-only.

The candidate resides under `A51mR2Backlight/Experimental/HDMIDDC`, outside the
KEXT build. Its offline preflight validates the module UUID, complete helper
hash, native encoder hash, executable bounds, unique complete helper match
and exact candidate footprint. Twelve rejection/integrity checks pass.
The repository's native fixture executes the authenticated reader and hardware
address-encoder copies in owned process memory with a mock bus: the original
has 254 wrong mappings across 256 input bytes; the candidate has zero. Standard
`0x6f` replies succeed in the continuing-response fixture after correction;
first/second-read failures retain their native error result.

The software-I2C fallback was traced separately. When the hardware engine
cannot be acquired, its native software payload encoder applies the same
left shift and read-bit insertion. Executing both authenticated encoder blocks
for all 256 address bytes gives the same results: 254 original mismatches,
zero after the candidate correction. Switching engines does not normalize
the address or bypass this defect.

Twelve further owned-object cases execute the current IOKit
`IOI2CSendRequest`, IOGraphics external-method wrapper and framebuffer-I2C
dispatch. They preserve the API reply address, transaction type, send address
and minimum reply delay. They also preserve the distinction between method
success and the bus result stored inside the request. This closes the upstream
address-normalization question without opening a real monitor interface.
Apple's public [IOI2CInterface implementation](https://github.com/apple-oss-distributions/IOGraphics/blob/76285384ff0ce63965a21b8023bf6d7e447fcc19/IOGraphicsFamily/IOI2CInterface.cpp)
agrees with the observed copying contract; the current installed binaries were
authenticated and tested independently of that historical source.

This establishes a reproducible code defect and correction, not acceptance on
the user's disconnected HDMI monitor. The split-read restart counterexample
still fails even after address correction; monitor behavior and physical bus
signals remain unmeasured. No runtime Lilu writer, EFI change, app preference
change or live hardware test was made. Integration must be reviewed before
activation, then validated on the actual HDMI display with strict reply checks,
separate audio testing and miniDP regression. Reinstalling NaviAudioFixup is
still not a new DDC repair. No matched genuine-Mac case has yet established
whether this exact failure is shared with comparable Apple hardware.

## Split-read STOP intent and a smaller compatibility option

The split-read question is now narrower than an arbitrary mock-monitor
restart. In the authenticated native hardware command loop, the reply helper
submits one read payload per command. The native transaction programming code
sets STOP for each read. Sixteen owned payload cases and two command-loop
cases confirm this intent, including two read payloads in one command. Field
names were independently checked against AMD's
[shift/mask struct](https://github.com/torvalds/linux/blob/aebb7274476403040d582c61478df8f4a7bf9cd3/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.h)
and [transaction implementation](https://github.com/torvalds/linux/blob/aebb7274476403040d582c61478df8f4a7bf9cd3/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c).
The header was retrieved separately; its reviewed blob is
`a9a16f6459940e573e137003c4b204f79972c097`. This establishes programmed intent,
not measured electrical signals or this monitor's response-cursor behavior.

A combined owned-code chain executes the address-corrected native reply
helper, native payload loop and native transaction-programming prefix. It
programs STOP after both the two-byte and nine-byte reads. A synthetic monitor
that preserves its response cursor succeeds; one that resets after STOP still
returns a corrupted reply. Thus the four-byte address correction is not a
complete compatibility guarantee.

The driver's **unmodified simple reply reader** was then executed through the
same native command/transaction prefixes. It shifts `0x6f` to `0x37` and reads
all 11 Get VCP reply bytes in one payload, with one STOP. The synthetic response
is intact, and a mocked bus failure preserves the native error. This reader
does not need the address patch. The test covers fixed-length Get VCP, not all
variable-length capabilities queries or a connected monitor.

This gives a concrete, smaller option **if the prepared connected-HDMI query
confirms simple replies work**:

1. In the existing KEXT, route the exported
   `AMDRadeonX6000_AmdRadeonFramebuffer::reportCapabilities_I2cInfo` method.
   Call Apple's original method first and preserve its result.
2. Require the verified driver build, a non-null active link and the actual
   framebuffer's HDMI connector type `0x800`. Fail closed for unknown metadata;
   keep miniDP, eDP and inactive-link defaults unchanged.
3. Copy the published `IOFBI2CInterfaceInfo` array/dictionary through normal
   IORegistry collection APIs. For an unambiguous ordinary-I2C entry that
   already supports simple replies, clear only
   `1 << kIOI2CDDCciReplyTransactionType` in `IOI2CTransactionTypes`:
   for example, `31 -> 27`. Authenticate the actual published mask rather
   than treating the disconnected default as a connected HDMI observation.
   Keep its bus, interface ID, communication flags and other bits.
   Publish the checked copy before the interface consumes its capabilities.
4. Applications that select from that specific interface's advertised mask can
   then use the existing full-response simple reader. The DDC/CI commands and
   checksum validation remain the same. This changes the reply transport
   advertisement, not the monitor protocol or physical fan/display settings.

The installed BetterDisplay 5.2.1 Intel backend's pure selection instructions
were executed on owned memory for all 256 masks. Mask 31 selects type 2,
mask 27 selects type 1, and the unchanged DP mask 15 still selects type 2.
Its actual registry discovery, hotplug refresh and HDMI communication have
not been exercised under the proposed capability change.

Ten owned-object executions of the complete native capability publisher also
checked the surrounding contract. It removes the old property, builds one
interface dictionary and publishes an array. Different raw active-signal codes
select different native tables; these raw codes were not assigned connector
names by borrowing another driver's enumeration. More importantly, array or
dictionary allocation failures still return zero, with no interface or an
empty array. A successful method return is therefore insufficient: a future
hook must validate the actual collection, field types and unique interface,
and preserve the original property if its own copying or publication fails.
No live kernel allocations or registry writes occur in these executions.

This is a **proposed compatibility repair**, not an implemented hook or a
general repair of the type-2 reader. Applications that force type 2 can still
fail. In particular, the reviewed MonitorControl source chooses from globally
enumerated interfaces rather than necessarily this output's interface; do not
claim that a per-HDMI capability adjustment fixes every client. No capability
mask, KEXT or application preference was changed. An active HDMI comparison,
explicit review and miniDP regression remain required before choosing this
option over a reader correction.

## Historical request-level compatibility candidate (unlinked, superseded)

Further consumer-side checks limit the capability-only proposal. Apple's
`IOFramebufferI2CInterface::withFramebuffer` copies the interface dictionary;
`start` caches its transaction mask, and `startIO` checks that cached value.
Interface creation occurs during framebuffer opening. Updating the parent's
capability array after a later HDMI connection is therefore insufficient to
prove that an existing interface or application will change its reply mode.
Do not deploy a registry-only edit as a verified hotplug repair.
[Apple IOGraphics 600 source](https://github.com/apple-oss-distributions/IOGraphics/blob/76285384ff0ce63965a21b8023bf6d7e447fcc19/IOGraphicsFamily/IOFramebuffer.cpp)

An alternative core is now implemented, but **not linked or installed**, in
the backlight checkout's `Experimental/HDMIDDC/request_transport.hpp`:

- A future route would enter the exported framebuffer
  `doI2CRequest(unsigned, IOI2CBusTiming *, IOI2CRequest *)`. The current native
  entry is module-relative `0x56b8`, 136 bytes, SHA-256
  `e6f622ec0e0e2f15a1f213b8e5cdf9f0678af3c2726beb9c449afe36aeabd52b`.
  This avoids replacing a system framework or rewriting the native readers.
- For a qualified **synchronous ordinary-I2C HDMI** request, temporarily use
  simple reply type 1 instead of DDC/CI reply type 2. The original command,
  send buffer, reply address, delay and bus stay unchanged. The native driver
  runs once; no retry command is added. Restore the request's original reply
  type before returning and preserve native method/request errors.
- Restrict the candidate to standard `0x6f` replies of 3–128 bytes, zero
  communication flags, and no-send or ordinary simple-send requests. Accept
  reply-subaddress byte zero or standard `0x51` only; with flags zero this byte
  is inert in the authenticated native Simple reader. Actual subaddress
  transactions still pass through unchanged.
  Other protocols pass through unchanged. It requires already-validated
  kernel-owned request/buffer lifetimes; it is not an arbitrary-pointer checker.
- A simple read fills the caller's capacity. The native DAL selector first
  zeroes the whole output, then the old DDC/CI helper fills only the encoded
  frame prefix. The candidate keeps that native zero tail on success; it does
  not restore bytes from before preclear. The original 128-byte snapshot was
  removed after extending the fixture to the complete reply selector. It does
  not correct a checksum, suppress an error or promote a
  malformed/truncated frame to valid protocol data.

The future runtime scope must authenticate the driver and current link on
every call, preserve miniDP/eDP, and require a successful connected-monitor
comparison. Current registry PCI metadata is Dell `1028:099d`, AMD `1002:731f`,
revision `c3`; the subsystem fields are not injected in the inspected EFI.
These are registry observations, not an independent config-space read.
No runtime qualification adapter, hook registration or boot argument was added.
All qualification fields default to false, and this file is outside Xcode.

`Tests/Display/test_native_hdmi_ddc_transport.py` compiles that core against the
actual SDK request declaration and executes authenticated copies of the
unchanged AMD DAL dispatch/reply selection, simple/DDC/CI readers and address
encoder in its own process.
It checks 16,128 synthetic payload-length/capacity combinations, buffer guards,
padding, checksum rejection by the caller, native method/request failures,
22 protocol/null negatives and seven qualification negatives. The modeled bus
restarts its reply at each read; the single native read preserves its frame.
The original command order, absolute-time wait interval, single preclear and
native method/request results are checked; a send error skips wait and read.
Locks, waits, command submission, AUX, eligibility and the physical bus remain
test boundaries.
Three further cases execute native DP/eDP/MST dispatch with HDMI and ordinary
I2C eligibility disabled: request type 2 and the AUX-DDCCI branch are retained,
including its mocked error and cleared output. This is a passthrough check,
not proof of working physical AUX or completed miniDP regression.
This is **not** a connected-monitor, hotplug, audio or full driver acceptance.

The same transport compiled as an unlinked kernel object with the real kernel
SDK, exceptions and RTTI disabled. The per-request transport has no allocator,
timer, persistent state or service. Nothing was added to EFI.

Two more unlinked pieces make the prospective integration specific:

- `request_identity.hpp` calls the same native `getMyLink(framebuffer,0)` used
  by the original request method, then requires connector object `0x310c` and
  a nonzero connected signal. It resolves the current link for every call;
  stream zero is not a fixed framebuffer or physical port. Fifteen owned native
  getter checks cover HDMI/DP/eDP remapping, offline, null and missing identity
  gates. The native request's existing object/lock scope is still a prerequisite.
- `request_contract.hpp` validates the module header/unique UUID and ten
  complete function or encoder-block hashes, including the DAL preclear/result
  path. Twenty-eight owned-data cases
  reject changed bodies, malformed/duplicate identities, failed reads/hashes
  and invalid spans, clearing all output addresses on rejection.
  `request_authentication.hpp` supplies the unlinked Lilu-side safe-copy,
  SHA-256 and exact-symbol/address binding. One-time hashes allocate through
  Lilu; that work does not belong in an I2C request wrapper. It has no route
  registration, initialization entry point or writer.

The combined transport, current-link matcher and authentication glue compiled
against the project's current Lilu headers and kernel SDK with explicit
no-SIMD flags. The owned object has no SIMD-register instructions, exception
runtime, timer or hook-registration imports. Its Lilu hash/resolver/free
dependencies are expected; this was not a linked or loaded KEXT.

Installed BetterDisplay's two fixed Get VCP callers request 11 reply bytes;
its capabilities caller requests 37. Their complete file-function hashes were
retained locally. This reinforces the scope limit: initial live integration
should be restricted to the fixed Get VCP profile actually compared, rather
than treating the synthetic 3–128-byte matrix as proof for every DDC command.
Variable-length capabilities and monitor behavior on over-read are separate
acceptance work. Actual GPU binding, live request lifetime/locking, connected
HDMI and unchanged miniDP behavior remain requirements. No full runtime
qualification adapter or request hook has been installed.

The actual request builder also revealed a candidate/test coverage gap:
BetterDisplay and the prepared probe populate `replySubAddress=0x51`, while the
first candidate rejected every nonzero byte and the old fixture left it zero.
The corrected fixture now uses `0x51` throughout its matrix. Another 256 direct
owned executions of the unchanged Simple reader prove that the byte is ignored
when `commFlags` is zero; both accepted fixed profiles (zero and `0x51`) pass.
The core deliberately retains a narrow whitelist and rejects actual flag-bit-1
subaddress transactions, alternate `0x50`, and nonzero send-address upper bits.
This fixes the unlinked candidate's coverage, not the running HDMI output.

The initial profile restriction is also implemented in unlinked
`request_profile.hpp`: five-byte Get VCP with standard addressing, header,
opcode and checksum, an eleven-byte reply and synchronous ordinary-I2C flags.
Capabilities/Set VCP/malformed/no-send profiles retain native behavior. The
disabled path checks qualifications before reading packet bytes. Two fixed
subaddress profiles, all 256 Get VCP feature-byte values and five rejection
profiles pass in the owned DAL fixture. This does not establish feature support
on a monitor, live GPU/link/lifetime qualification or a working HDMI output.

The standard caller's locking boundary is now more specific. The current
`IOFramebufferI2CInterface::startIO` closes the controller work-loop gate before
checking active/powered state and calling framebuffer virtual slot `0x878`;
it releases that gate only after method/request-result handling. This matches
[Apple's startIO source](https://github.com/apple-oss-distributions/IOGraphics/blob/76285384ff0ce63965a21b8023bf6d7e447fcc19/IOGraphicsFamily/IOFramebuffer.cpp).
The existing native API `IOWorkLoop::inGate()` can test whether the current
thread already owns the gate, avoiding a new competing lock. This establishes
the standard caller's scope, not all possible internal callers or AMD link
lifetime ownership; a future route must reject unsupported caller/scope paths.
No gate-checking live route or additional lock was installed.

## Genuine-Mac comparison and the agreed scope limit

A genuine AMD Mac Pro 2019 user reported the same broad symptom—DisplayPort
DDC worked while built-in HDMI did not—in
[ddcctl issue 62](https://github.com/kfix/ddcctl/issues/62#issuecomment-586681170).
That old report does not establish the same code defect on this Tahoe/Navi
driver, and it contains no successful HDMI repair. It does show that the
symptom alone is not evidence of a wrong A51m EFI or DSDT. Apple-Silicon HDMI
converter limitations are another architecture and are not used as an A51m
diagnosis.

The user's rule is to skip problems shared with genuine Macs. Therefore do
not turn this candidate into a broad AMD transport rewrite merely because a
native-code counterexample exists. Establish the connected A51m failure and
whether the same mechanism is shared before choosing a machine-specific
repair. Current sound mapping remains a separate, already configured
NaviAudioFixup path; neither a similar genuine-Mac DDC report nor a transport
candidate proves HDMI audio fixed.
