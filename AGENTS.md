# AI instructions for this repository

## Repository scope
- This is Cameron's external QMK userspace at `~/Documents/qmk_userspace`.
- It is separate from the QMK firmware checkout at `~/Documents/qmk_firmware`.
- This userspace was migrated from a personal firmware fork; do not assume it is a full firmware tree.
- Work in this userspace unless the user explicitly asks you to work elsewhere.
- Do not add dependencies, scripts, workflows, renames, or unrelated cleanup without a request.

## Keymap and source files
- The personal target is `sofle/rev1` with keymap name `cameronchan`.
- The canonical layout input is `keyboards/sofle/keymaps/cameronchan/map.json`.
- `map.json` uses the QMK Configurator JSON format. It is named `map.json`, not `keymap.json`.
- Firmware behavior is implemented in `keyboards/sofle/keymaps/cameronchan/keymap.c`.
- The C source includes keymaps and custom OLED and encoder behavior; preserve those behaviors when editing.
- `config.h` and `rules.mk` tune firmware behavior and build options for this keymap.
- Root `keymap.yaml` and `keymap.svg` are derived diagram artifacts, not layout sources.
- Never hand-edit generated diagram output to change the layout; update its source deliberately.

## Keep layout and firmware changes deliberate
- Do not assume `map.json`, `keymap.c`, and the generated diagram synchronize automatically.
- Editing `map.json` alone is not proof that the named firmware keymap has changed.
- Compare the layout table and synchronize representations deliberately when requested.
- Preserve custom C behavior while synchronizing; never blindly overwrite `keymap.c` with `json2c` output.
- A known discrepancy exists: layer 5 in `map.c` uses `AG_SWAP`, while `keymap.c` uses `AG_TOGG`.
- Treat that discrepancy as a warning to inspect, not as permission to resolve or overwrite either source.
- Preserve layer order, key positions, mod-tap semantics, and layer-tap semantics unless explicitly asked to change them.
- Leave `qmk.json` build targets unchanged unless the user specifically requests a target change.

## Diagram generation
- From the userspace root, the confirmed parse command is:
  ```sh
  keymap parse -q keyboards/sofle/keymaps/cameronchan/map.json > keymap.yaml
  ```
- Only after parsing succeeds, the confirmed draw command is:
  ```sh
  keymap draw keymap.yaml > keymap.svg
  ```
- Prefer temporary output files if a tool fails or if success is uncertain, so existing artifacts are not truncated.
- Replace derived artifacts only after successful generation and only when appropriate to the requested change.

## QMK configuration and build checks
- `qmk.json` declares userspace version `1.1` and build target `[["sofle/rev1", "cameronchan"]]`.
- The README documents these firmware validation commands:
  ```sh
  qmk compile -kb sofle/rev1 -km cameronchan
  qmk userspace-compile
  ```
- Treat those as validation commands, not as evidence that a build has already succeeded.
- For firmware changes, run a relevant compile when available and report the exact command and actual result.
- State clearly when a check was not run or was blocked; do not imply success without output.
- Documentation-only changes do not require a firmware compile.
- Lightweight JSON checks, when relevant, are:
  ```sh
  python3 -m json.tool keyboards/sofle/keymaps/cameronchan/map.json
  python3 -m json.tool qmk.json
  ```
- These checks print formatted JSON to stdout; redirect to `/dev/null` if only validation is needed.
- `qmk config` and `qmk userspace-list` are read-only configuration inspection commands.
- Do not run setup/install commands or mutate global QMK configuration automatically.
- The intended overlay and firmware home paths are known; write QMK configuration only when the user requests setup.

## Safety and user data
- Inspect the working tree before changes and preserve unrelated user work.
- In particular, `qmk.json` is already modified and `keyboards/sofle/`, `keymap.yaml`, and `keymap.svg` are already untracked in the supplied working tree.
- Do not overwrite, stage, or remove those pre-existing changes unless the user explicitly asks.
- Never flash firmware or reset connected hardware without an explicit request.
- Do not commit, push, or dispatch CI workflows without an explicit request.
- `.github/workflows/build_binaries.yaml` uses upstream QMK userspace reusable workflows and publishes binaries; do not change it for routine keymap work.

## Completion reports
- Summarize the files and behavior changed, keeping the report concise.
- List checks actually performed and their results; distinguish skipped and blocked checks.
- For validation, focus on the smallest relevant checks rather than broad unrelated test suites.
