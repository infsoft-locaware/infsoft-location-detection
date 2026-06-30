# infsoft Location Detection SDK

 [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finfsoft-locaware%2Finfsoft-location-detection%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/infsoft-locaware/infsoft-location-detection)
 [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finfsoft-locaware%2Finfsoft-location-detection%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/infsoft-locaware/infsoft-location-detection)

Use the infsoft location detection SDK to collect device sensor data, send it to the location calculation service, and receive calculated user positions for indoor and outdoor positioning.
This repo is a wrapper around the distributed binary sdk for usage with the Swift Package Manager.

## Overview

`location_detection` is an iOS framework that coordinates local sensors and forwards their data to the infsoft positioning backend. The framework periodically emits ``UserLocation`` values through the callback passed to ``UserLocationManager/initialize(handler:config:)``.

The SDK can use the following sensor inputs, depending on configuration, device support, and app permissions:

- ARKit camera motion
- GPS / Core Location
- BLE beacon ranging
- UWB accessory ranging with Nearby Interaction
- Barometer pressure
- Compass heading

The host app remains responsible for requesting user permissions before initializing the SDK. The SDK checks permission state, starts only the scanners that are available, and exposes missing permissions through ``UserLocationManager/getNonGrantedPermissions()``.

## Installation

Use the public [Swift Package Index](https://swiftpackageindex.com/infsoft-locaware/infsoft-location-detection).
The package repository points to the published binary framework and is updated with each SDK release.

In Xcode, choose **File > Add Package Dependencies**, enter `https://github.com/infsoft-locaware/infsoft-location-detection.git`, and select version `0.1.1` or newer.

## Usage

Import the framework and create a configuration with your API key:

```swift
import location_detection

let config = SdkConfiguration(
    apiKey: "YOUR_API_KEY",
    arCameraEnabled: true,
    gpsEnabled: true,
    bleEnabled: true,
    uwbEnabled: true,
    barometerEnabled: true,
    compassEnabled: true,
    language: "en",
    iBeaconId: UUID(uuidString: "<your custom iBeacon id>")! // only required if you are not using infsoft's hardware
)
```

Initialize the manager on the main actor and keep the returned instance for as long as location detection should continue:

```swift
private var locationManager: UserLocationManager?

@MainActor
func startLocationDetection() {
    locationManager = UserLocationManager.initialize(
        handler: { location in
            Task { @MainActor in
                print(location.latitude, location.longitude, location.level)
            }
        },
        config: config
    )
}
```

Stop the SDK when location detection is no longer needed:

```swift
Task {
    await locationManager?.stop()
}
```

### Permissions

Request permissions in the app before calling ``UserLocationManager/initialize(handler:config:)``. The SDK does not present permission prompts itself.

Add the required usage descriptions to the app target's `Info.plist` for the sensors you enable:

- `NSLocationWhenInUseUsageDescription` for GPS and BLE beacon ranging.
- `NSBluetoothAlwaysUsageDescription` for BLE and UWB accessory scanning.
- `NSCameraUsageDescription` for ARKit camera motion.
- `NSNearbyInteractionUsageDescription` for UWB accessory ranging.
- `NSMotionUsageDescription` if the app uses motion features that require it in the target deployment environment.

Request runtime access in your app flow before SDK initialization. For example, request Core Location and camera access from the sample app or onboarding screen, then call ``UserLocationManager/initialize(handler:config:)`` after the user has answered.

After initialization, inspect missing permissions, e.g., to show the user a banner:

```swift
Task {
    let missing = await locationManager?.getNonGrantedPermissions() ?? []
    print(missing.map(\.rawValue).joined(separator: ", "))
}
```

### Configuration

Use ``SdkConfiguration`` to control which sensors are active.

- ``SdkConfiguration/apiKey``: API key used for backend requests.
- ``SdkConfiguration/identifier``: Optional identifier sent with requests, useful for debugging purposes, so infsoft can correlate your specific requests.
- ``SdkConfiguration/arCameraEnabled``: Enables ARKit motion collection.
- ``SdkConfiguration/gpsEnabled``: Enables Core Location GPS data.
- ``SdkConfiguration/bleEnabled``: Enables BLE beacon ranging.
- ``SdkConfiguration/uwbEnabled``: Enables UWB accessory ranging through CoreBluetooth and Nearby Interaction.
- ``SdkConfiguration/barometerEnabled``: Enables pressure readings when the device supports barometer data.
- ``SdkConfiguration/compassEnabled``: Enables compass heading readings when available.
- ``SdkConfiguration/language``: Language code sent to the backend, this localizes the metadata information.
- `SdkConfiguration/iBeaconId`: UUID used as constraint for iBeacon ranging, only required to be set, when custom hardware is used.

Disabled sensors are not started and are marked disabled in debug sensor output.

### Location Updates

The SDK calls the initialization handler with a ``UserLocation`` each time the backend returns a valid calculated position.

A location contains:

- ``UserLocation/latitude`` and ``UserLocation/longitude`` in WGS84 decimal degrees.
- ``UserLocation/level`` for indoor floor / level selection.
- ``UserLocation/accuracyInMeters`` with the backend accuracy estimate.
- ``UserLocation/meta`` with building, space, source, timestamp, subscription, and map API key metadata, this is localized to the configured language.

The callback can arrive from SDK work, so dispatch UI updates to the main actor:

```swift
locationManager = UserLocationManager.initialize(
    handler: { location in
        Task { @MainActor in
            latitudeLabel.text = "\(location.latitude)"
            longitudeLabel.text = "\(location.longitude)"
            levelLabel.text = "\(location.level)"
        }
    },
    config: config
)
```

### Position Metadata

``MetaInformation`` describes the calculated position context:

- ``MetaInformation/levelName``: Human-readable level name, when provided by the backend.
- ``MetaInformation/buildingName`` and ``MetaInformation/buildingId``: Building context.
- ``MetaInformation/spaceName`` and ``MetaInformation/spaceId``: Space or room context.
- ``MetaInformation/positionSource``: Set of ``PositionSource`` values used for the calculation.
- ``MetaInformation/timestamp``: Backend position timestamp in milliseconds since Unix epoch.
- ``MetaInformation/subscriptionId``: Subscription identifier returned by the backend.
- ``MetaInformation/mapApiKey``: Map API key for loading related map styling and assets.

Format the position sources by joining their raw values:

```swift
let sources = location.meta.positionSource
    .map(\.rawValue)
    .sorted()
    .joined(separator: ", ")
```

### Sensor Sources

``PositionSource`` indicates which sensor families contributed to a returned position:

- ``PositionSource/gps``: GPS contributed.
- ``PositionSource/ble``: BLE beacon ranging contributed.
- ``PositionSource/uwb``: UWB ranging contributed.
- ``PositionSource/unknown``: No specific source was identified.

The value is exposed as ``PositionSources``, a set of ``PositionSource`` values, because multiple sensors can contribute to a single calculated position.

## Notes

### Raw sensor Data

``SharedSensorData`` exposes the latest raw values held by the SDK for debug displays:

- ``SharedSensorData/latitude``
- ``SharedSensorData/longitude``
- ``SharedSensorData/altitude``
- ``SharedSensorData/accuracy``
- ``SharedSensorData/azimuth``
- ``SharedSensorData/pressure``
- ``SharedSensorData/arX``
- ``SharedSensorData/arY``
- ``SharedSensorData/arZ``

Use this type for diagnostics only. Production app logic should rely on ``UserLocation`` updates from the manager callback.

### UWB

UWB ranging requires:

- A device that supports Nearby Interaction precise distance measurement.
- Bluetooth permission.
- Nearby Interaction permission.
- Compatible UWB accessories advertising the expected service and characteristics (infsoft's LocatorBeacons).

The SDK scans for accessories, exchanges Nearby Interaction configuration data, and forwards distance measurements as `UwbData` in backend requests. The public result remains ``UserLocation``; raw UWB packets are internal implementation details.

### Lifecycle

`UserLocationManager` automatically observes app foreground/background notifications. When the app enters the background, it schedules scanner shutdown after a short delay. When the app becomes active again, it resumes scanners if location detection was running.

Call ``UserLocationManager/stop()`` when the app no longer needs active location detection. This stops all scanners and cancels the SDK worker loop.

## Automatic Updates

This repository is updated automatically whenever a new binary is available.
The pipeline updates `main` and creates a matching [semantic version](https://semver.org/) tag.


## Licensing

The source code contained in this repository is licensed under the MIT License.
 
This package depends on a proprietary binary artifact that is distributed separately and is not licensed under the terms of this repository.
 
Use of the binary artifact requires a valid purchased license.
A license includes the API key required to use the SDK.
 
Unauthorized use or distribution of the binary artifact is prohibited.
 
For licensing, purchase requests, or additional information, contact [contact@infsoft.com](mailto:contact@infsoft.com).

