# Public repository privacy

Never commit a working machine's personalized EFI or raw diagnostic output.

- Keep all System/Board/Chassis serial fields, SystemUUID, MLB and ROM blank
  or zeroed in public configuration, including inactive PlatformInfo sections.
- Use "peer Mac" in documentation. A hostname may itself be a hardware serial;
  abbreviating it is not sufficient anonymization. Do not publish peer device
  IDs, Bonjour records, account identifiers, IP/MAC inventories or state dumps.
- Keep diagnostic archives, screenshots, traces, IORegistry/NVRAM dumps, EFI
  backups and ACPI firmware-license tables outside this worktree.
- Existing raw DarwinDumper output, the firmware MSDM table and its dump log
  were removed from the current public tree. Previously populated identity
  fields were cleared. Prior Git history may still contain old material;
  this change does not rewrite history or revoke an already exposed identity.
- Software image UUIDs and artifact SHA-256 values identify binaries, not
  hardware. They may be published for version checks.

Before publishing:

```sh
python3 scripts/check_release.py
```

For an additional local check, supply `--private-identifiers /outside/repo/ids.json`.
The private JSON array accepts objects containing either `text` or `hex`.
The checker looks for those values in candidate files, decoded plist values
and common encodings. It prints paths/categories only, never matching values.
Do not add that denylist to Git. This check complements review; it cannot
recognize every unknown identifier in arbitrary binary formats or old history.
