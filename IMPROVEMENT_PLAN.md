# Setonix improvement plan

Reviewed on 2026-09-30 against commit `e38aa25` (`Add restricted tables`).

## Direction

Prioritize reliable offline play, durable saves, and predictable multiplayer before adding more features. Keep the existing separation between shared Dart models/event processing (`api`), the Flutter/Flame client (`app`), the dedicated server (`server`), and the Dart/Rust Luau bridge (`plugin`). Improve those boundaries incrementally.

The repository already has useful protections: protocol negotiation, authentication origin binding and replay checks, role authorization, payload validation, and encrypted account backups. Preserve these and extend their test coverage.

## Review scope and baseline

- Inspected package manifests, contributor documentation, GitHub workflows, shared event processing, client/server world orchestration, persistence, plugin execution, and the Astro server directory.
- Used the existing graphify graph for orientation, then checked current source. The graph was generated in July and uses an older node-ID scheme; it is unsuitable as sole evidence for current behavior.
- Ran the API test suite using the installed Dart 3.13.4 SDK: **25 tests passed**.
- Ran the server test suite after its native build hooks completed: **26 tests passed**, including the connected-client shutdown test. Flutter UI, standalone Rust tests, website, and cross-platform builds have not been validated as part of this planning review.
- The checkout already contained an edit to `api/pubspec.lock`; leave that work intact.
- Risks below distinguish observed implementation gaps from behavior that still needs a reproduction. This is a targeted review, not an exhaustive audit or a performance benchmark.

## Ordered work

### 1. Make CI enforce correctness — P0, small

**Evidence:** `.github/workflows/dart.yml:8` sets job-level `continue-on-error: true`; its test step is commented out at line 69. Existing API and server suites therefore do not run in this workflow. The app has two test files; `app/test/widget_test.dart` tests string helpers rather than widgets. No plugin test directory or Rust test annotations were found in the inspected source.

**Actions:**

- Make analysis, formatting, generation consistency, and tests fail the relevant PR checks. Configure those checks as required separately in repository settings.
- Run `dart test` for `api` and `server`, and `flutter test` for `app`. Add Rust tests with the scripting work below; run `cargo fmt --check`, `cargo clippy`, and `cargo test` with the documented toolchain.
- Add PR validation for `docs` and `servers`. The current deployment workflows do not supply website PR checks.
- Correct `.github/workflows/servers.yml:22`, where pnpm setup targets `docs` while the job builds `servers`.
- Establish one documented local check command. Preserve generation-diff checks; include every package that owns generated output. Remove the duplicate checkout in the Dart workflow.

**Done when:** a deliberately failing test or analyzer error fails a PR check; a clean checkout can run the same checks locally; generated artifacts remain unchanged after regeneration.

### 2. Make saves durable and coalesce overlapping requests — P0, medium

**Evidence:** `server/lib/src/bloc.dart:170` writes directly to the destination world file. Both server and client save methods return immediately when `_isSaving` is true (`app/lib/bloc/world/bloc.dart:201`). These are observed gaps; loss of the last update during a particular overlap still needs a deterministic reproduction.

**Actions:**

- Introduce a save coordinator with a dirty revision and one active write. If state changes during a write, persist the latest revision before resolving a flush.
- On the server, write to a temporary file in the destination directory, flush, and replace the destination with platform-appropriate handling. Keep a recoverable previous version and validate saves on load.
- Verify the app filesystem backend's guarantees before changing it; define equivalent completion semantics for desktop files and browser storage.
- Make close/stop await pending work and a final flush. Surface save failures and allow retry without discarding the current world.

**Done when:** tests with a delayed writer preserve the final world and script state; injected write failure leaves the previous save readable; shutdown waits for the newest revision. Include a server restart round trip.

### 3. Own multiplayer subscriptions and order world mutations — P1, medium

**Evidence:** the client subscribes to three multiplayer streams without retaining subscriptions (`app/lib/bloc/world/bloc.dart:99`), and its `close()` does not cancel them. The dedicated server calls asynchronous `onClientEvent` from a void callback (`server/lib/src/server.dart:495`). Server-event reducers are sequential, but that does not establish ordering for the entire client validation/plugin/response pipeline.

**Actions:**

- Retain and cancel subscriptions as part of world disposal; prevent callbacks from starting work during close. Apply the same ownership review to connection close listeners in `app/lib/bloc/multiplayer.dart`.
- Add a per-world ingress queue with explicit ordering across validation, script execution, state application, and response construction. Establish a bounded queue policy for overload.
- First reproduce competing operations against the same object with controlled delays. Avoid serializing unrelated discovery or UI work.
- Extend current server shutdown coverage with repeated client open/close, reconnect, and two-client mutation cases. Capture asynchronous errors with world/channel/event context.

**Done when:** late events after close are ignored; repeated open/close does not increase active subscriptions; two clients converge after conflicting moves and disconnects; queue errors do not stop subsequent processing.

### 4. Bound downloads and tolerate broken directory sources — P1, medium

**Evidence:** `servers/src/scripts/servers/list.ts:14` fetches remote lists without a deadline, trusts their shape with a type cast, and uses `Promise.all`, so a rejected source can reject the entire list load. `ServerObject` exists but is not used to parse remote entries. Its URL schema also differs from the host/port format consumed by `buildServerURL`. `servers/src/scripts/servers/info.ts:97` reads the entire thumbnail before checking actual size. `app/lib/services/file_system.dart:320` downloads complete pack bodies without an explicit deadline or size bound.

**Actions:**

- Define and validate a consistent server-address format, including paths and IPv6. Parse remote lists and status payloads at runtime.
- Add deadlines, bounded response streams, source/list limits, concurrency limits, and in-flight request deduplication. Include scheme and normalized address in cache keys; make negative-cache entries actually avoid repeat fetches.
- Isolate each remote list failure and return usable local/cached entries. Show a useful partial-results state.
- Restrict server-side outbound destinations and redirects according to the deployment's allowed network scope; verify resolved destinations as well as input text.
- Keep pack hash verification. Define compressed and expanded archive limits, asset-count limits, and structured import errors at the layer that decodes archives.

**Done when:** a hanging or malformed remote source cannot break the directory; oversized bodies stop reading at the limit even without `Content-Length`; address tests cover host/port, path, TLS, and IPv6; a failed pack import does not leave a partial installation.

### 5. Make scripting failures recoverable and bounded — P1, medium/large

**Evidence:** native Luau uses `sandbox(true)` but has no configured memory or execution budget in `plugin/rust/src/api/luau.rs:185`. Event conversion and initialization contain several `unwrap()` calls. The event system holds its mutex while awaiting handlers (`luau.rs:163`), while handler connect/disconnect operations also acquire that mutex (`luau/event.rs`); reproduce this reentrancy risk. Local web gameplay skips loading game-mode scripts (`app/lib/bloc/world/bloc.dart:391`), and the WASM Luau implementation returns an unsupported error.

**Actions:**

- Set runtime-enforced memory and instruction/execution limits. An outer async timeout alone must not be assumed to interrupt a CPU-bound script.
- Replace fallible bridge conversion panics with structured plugin errors. Decide and test the policy for disabling a failed script and preserving world state.
- Snapshot handlers under the event-system lock and release it before invoking callbacks; specify handler registration/removal semantics during dispatch.
- Add Rust and bridge tests for malformed events, script exceptions, runaway loops, memory limits, handler self-disconnection, and state save/load.
- Expose platform script capabilities before choosing a game mode. Explain unavailable local web modes in the UI while retaining supported multiplayer behavior.

**Done when:** a bad script cannot panic or indefinitely block a world; callbacks can disconnect themselves; failures identify the script and operation; unsupported modes produce a clear explanation.

### 6. Add user-visible recovery and meaningful application tests — P1, medium

**Evidence:** `_WorldServerInterfaceImpl.print` is an empty TODO (`app/lib/bloc/world/bloc.dart:47`), and game-mode load errors are printed only in debug builds. Current app tests cover account backup and string helpers, leaving primary gameplay flows untested.

**Actions:**

- Introduce consistent error categories for connection, protocol compatibility, authentication, missing packs, save failure, and script failure. Keep developer detail in diagnostic logs and give players a concrete recovery action.
- Add widget tests for create/open/import, unavailable modes, failed connections, and save error/retry. Add an integration flow for offline play and a two-client dedicated-server session.
- Document protocol compatibility separately from application versions. Extend existing negotiation tests with transport-level mismatch and reconnect cases.

**Done when:** critical failures are visible in release builds; a player can retry or return to their world; the offline and multiplayer happy paths run in CI without public network services.

### 7. Improve onboarding and measure before optimizing — P2, small/medium

**Evidence:** `CONTRIBUTING.md` links bugs and translations to Qeck, references a `versioned_docs` directory absent from this checkout, and claims `app/README.md` documents all subdirectories although it only links to the root README. World orchestration mixes persistence, networking, plugins, and UI state. Both app and server compute each server event separately and save after processed state changes; their cost has not been measured. Board viewport culling already exists in `app/lib/board/grid.dart`.

**Actions:**

- Fix contributor links and document package responsibilities, generation order, exact toolchain expectations, native setup, local server startup, and the check command from item 1.
- Refresh root preview limitations against actual protocol and authorization behavior. Explain local web scripting support accurately.
- After lifecycle and persistence tests exist, extract small save, session, and plugin services where they reduce duplicated ownership. Retain shared reducers in `api`.
- Create repeatable workloads for a crowded board, rapid object moves, large pack import, and multiple clients. Measure frame time, event latency, isolate overhead, serialization, save time, and peak memory on representative devices.
- Optimize the measured bottleneck. Preserve event ordering; consider save coalescing and persistent workers only if the measurements justify them.
- Refresh the architecture graph after structural changes and record its source revision.

**Done when:** a new contributor can build and test from a clean checkout using the guide; package ownership is explicit; performance changes include before/after results for the same workload.

## Suggested delivery sequence

1. **PR 1:** required CI checks, correct server-directory setup, and contributor quick-start corrections.
2. **PR 2:** persistence coordinator, server replacement writes, and failure/shutdown tests.
3. **PR 3:** subscription disposal and a reproduced, tested world-event ordering policy.
4. **PR 4:** validated and bounded directory/pack networking.
5. **PR 5:** Luau error propagation, handler reentrancy fix, and runtime budgets; split into smaller PRs if needed.
6. **PR 6:** recovery UI, gameplay integration coverage, and platform capability messaging.
7. **Follow-up:** profiling and narrowly scoped service extraction, guided by measured costs and the new tests.

Effort labels are relative implementation sizes, not calendar promises. Start with PR 1: it protects every subsequent improvement using tests the repository already has.
