# ChangeLog

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
