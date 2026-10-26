# ChangeLog

## 0.2.9
- macOS: every request carries the `mac` hints whether the Mac stands still or was moved - `docked` (network cable, external display or lid closed), `desktop` (no internal battery), `bssidChanged` (the Wi-Fi access point changed since the previous request; reading the BSSID needs the location permission) and `wokeAt` (the last wake from sleep). The backend reads them since its Mac estimator; from BLE alone it cannot tell a beacon the scans miss for seconds from a move
## 0.2.8
- Fix location detection starting again on its own after the app stopped it: a wake (on macOS also the display coming back on) restarted a stopped manager, which then ran beside the next one the app initialized - two request loops on one backend session, splitting the readings between them. A wake now resumes only what the sleep paused
## 0.2.7
- Fix location detection stopping for good when the system woke within 2 s of going to sleep (on macOS also when only the display went off and on): cancelling the scheduled stop ran the stop at once instead of dropping it, after the wake had found the manager still running
## 0.2.6
- Fix crashes after hours of running (heap corruption, `EXC_BAD_ACCESS` in `swift_release_dealloc`): the collected readings and the shared configuration and session are now behind a lock - the scanners wrote them from their queues while the request loop took and reset them on another thread
## 0.2.5
- Add `UserLocationManager.resetSession()` and `UserLocationManager.sessionId`: an app can start a new backend session, so the backend calculates from scratch instead of continuing from what the old session held. Readings collected for the old session are dropped; the client id stays
## 0.2.4
- Add opt-in diagnostics: `LocationDetectionDiagnostics.setHandler(_:)` gets every request body sent to the positioning backend and its answer, one line each - for an app that lets its user turn on log files. Nothing is built or logged without a handler; the API key is never written
## 0.2.3
- Send the beacon's calibrated RSSI at 1 m (iBeacon measured power) as `txPower` on macOS instead of 0 - the backend took every beacon for kilometers away and reported the accuracy far too large
## 0.2.2
- Detect BLE beacons on macOS: Core Location does not range beacons there, so the iBeacon frames are read from a CoreBluetooth scan (one mean RSSI per beacon and second)
## 0.2.1
- Fix Swift Package Manager integration for macOS
## 0.2.0
- Add macOS support (GPS and BLE beacon ranging; AR, UWB, barometer, and compass remain iOS-only)
- On macOS, scanners pause while the system sleeps instead of on app backgrounding
- Send `X-OS: MACOS` to the backend on macOS
- Binaries are now published under `sdk.infsoft.com/apple/`
- Add unit tests
## 0.1.1
- Allow to specify a custom iBeacon UUID for BLE scanning
## 0.1.0
- Implement UWB beacon ranging

## 0.0.4
- Minor refactoring

## 0.0.3

- Improved docs
- Set minimum swift version to 6.0, required for the version constraint

## 0.0.2

- Add swift package index labels
- Set minimum swift version to 5.3

## 0.0.1

- Initial prototype implementation
- Add deployment for Swift Package Manager to Github
