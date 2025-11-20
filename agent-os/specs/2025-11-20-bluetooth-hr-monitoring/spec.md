# Specification: Bluetooth Heart Rate Monitoring with Real-Time Display

## Goal
Enable users to connect to Bluetooth heart rate monitors and view real-time heart rate data with color-coded zones, continuous automatic recording to encrypted local storage, and basic session statistics.

## User Stories
- As a fitness enthusiast, I want to connect my Bluetooth heart rate monitor to see my real-time heart rate displayed with color-coded zones so that I can monitor my workout intensity
- As a user without a physical device, I want to use a demo mode to explore the app's features before purchasing a heart rate monitor

## Specific Requirements

**Device Discovery and Connection Screen**
- Display on app launch when no device is currently connected
- Show "Scan for Devices" button to initiate BLE scanning for devices advertising Heart Rate Service (0x180D)
- List discovered devices with device name and signal strength indicator
- Include a "Demo Mode" device as first item in the list for testing without physical hardware
- Show loading state during scanning with "Scanning..." text and progress indicator
- Tapping a device initiates connection and navigates to main monitoring screen
- Persist last connected device preference for quick reconnection on subsequent launches
- Show Bluetooth disabled state with explanation and button to open system settings

**Bluetooth Permission Explanation Screen**
- Display before first permission request explaining why Bluetooth access is needed
- Simple text: "This app needs Bluetooth access to connect to your heart rate monitor"
- Include "Grant Permission" button that triggers system permission dialog
- On Android, also explain location permission requirement (OS requirement for BLE scanning)
- If permission denied, show error screen with "Retry" button to request again

**Main Heart Rate Monitoring Screen**
- Large, center-aligned current heart rate value (120+ sp font size) that is easily readable from distance
- Current BPM value changes color based on calculated heart rate zones
- Real-time line chart below showing last 30 seconds of heart rate data (configurable via settings)
- Chart updates smoothly as new data arrives every 1-2 seconds
- Connection status indicator at top (Connected/Disconnecting/Reconnecting with device name)
- Session statistics panel showing: Duration (HH:MM:SS), Average HR, Min HR, Max HR
- All statistics update in real-time as session progresses
- Small settings icon in app bar to access settings screen
- Device name displayed in app bar title

**Heart Rate Zone Color Coding**
- Calculate maximum heart rate: Max HR = 220 - user age (from settings)
- Below 50% max: Blue color
- Zone 1 (50-60% max): Gray or Light Blue color
- Zone 2 (60-70% max): Green color
- Zone 3 (70-80% max): Yellow color
- Zone 4 (80-90% max): Orange color
- Zone 5 (90-100% max): Red color
- Current BPM number and chart line color both reflect current zone
- Smooth color transitions when crossing zone boundaries

**Continuous Data Recording**
- Recording starts automatically when device connects successfully
- Heart rate readings sampled and stored every 1-2 seconds to local encrypted database
- Each reading includes: timestamp, BPM value, session ID reference
- Session metadata captured: session ID, start time, device name
- Recording continues until device disconnects
- Session end time, average HR, min HR, max HR calculated and stored on disconnect
- No user interaction required to start or stop recording

**Auto-Reconnection Logic**
- On unexpected disconnect, immediately attempt to reconnect to last device
- Display "Reconnecting..." message with attempt count (1 of 10)
- Retry up to 10 times with exponential backoff: 2s, 4s, 8s, 16s, then 30s intervals
- Continue showing last received heart rate value (grayed out) during reconnection
- After 10 failed attempts, show "Connection Failed" dialog with two buttons: "Retry" (restart 10 attempts) and "Select Device" (return to device selection)
- If reconnection succeeds, resume recording in same session
- If user chooses "Select Device", end current session and navigate to device selection

**Settings Screen**
- Age input field (numeric, 10-100 range, default 30) for heart rate zone calculation
- Chart time window slider (15/30/45/60 seconds options, default 30)
- Display calculated max heart rate based on age input
- Show calculated zone ranges in BPM for user's age
- Settings persist to local storage and apply immediately
- Accessible via settings icon on main monitoring screen

**Demo Mode Implementation**
- "Demo Mode" device appears as first item in device list with distinct icon
- Connecting to demo device simulates realistic heart rate data
- Generate BPM values between 60-180 with natural variability (±2-5 BPM per sample)
- Simulate gradual increases and decreases over 30-60 second periods
- Update at same 1-2 second interval as real device
- All features work identically to real device connection
- Demo mode helpful for testing, screenshots, and user evaluation without hardware

**Error Handling and User Messaging**
- All error messages use simple, non-technical language focused on user action
- Bluetooth disabled: "Bluetooth is turned off. Please enable it in your device settings."
- Permission denied: "Bluetooth permission is required to connect to heart rate monitors."
- No devices found after scan: "No heart rate monitors found. Make sure your device is turned on and in range."
- Connection timeout: "Could not connect to [Device Name]. Make sure it's turned on and nearby."
- Generic BLE error: "Something went wrong. Please try again."
- Each error includes relevant action button (Retry, Open Settings, Back to Devices)

## Visual Design
No visual mockups provided. Follow Material Design guidelines for Flutter with emphasis on:
- Large, readable text for distance viewing of heart rate
- Clean, uncluttered layout focusing on current BPM as hero element
- Color-coded zones using specified colors for immediate visual feedback
- Smooth animations for value changes and color transitions
- Responsive layout adapting to different screen sizes and orientations
- Appropriate use of whitespace and visual hierarchy

## Existing Code to Leverage

**Flutter StatefulWidget Pattern from main.dart**
- Use similar structure for screens requiring state management (monitoring screen, device list)
- Follow existing pattern of separating widget class from state class
- Use setState for local UI updates (BPM display, timer)

**MaterialApp Theme Configuration from main.dart**
- Extend existing ThemeData to include custom colors for heart rate zones
- Define ColorScheme with zone colors (blue, gray, green, yellow, orange, red)
- Apply theme consistently across all screens

**Material Design Widget Structure from main.dart**
- Use Scaffold with AppBar pattern for all screens
- Follow existing conventions for title, actions, and body layout
- Maintain consistent navigation and visual style

**Flutter SDK Dependencies from pubspec.yaml**
- Build upon existing Flutter SDK ^3.10.0
- Add new dependencies: flutter_blue_plus, flutter_riverpod, sqflite_sqlcipher, fl_chart, csv, shared_preferences
- Maintain Material Design icon and font usage

**Linting Configuration from analysis_options.yaml**
- All new code must pass flutter_lints ^6.0.0 recommended lints
- Follow linting rules consistently with existing codebase
- Run flutter analyze before committing code

## Out of Scope
- Manual start/stop workout controls - data records automatically when connected
- Session naming or workout notes functionality
- Historical data visualization beyond current session statistics
- GPS tracking or location-based features
- Social features, sharing, or cloud synchronization
- Integration with third-party fitness services or health platforms
- Multiple simultaneous device connections
- Advanced analytics like heart rate variability (HRV) or VO2 max estimation
- Calorie calculation or energy expenditure tracking
- Workout planning, scheduling, or goal setting features
- Audio or haptic feedback for zone changes
- Export functionality (deferred to future CSV export feature)
- Custom zone configuration beyond age-based calculation
- Session history browsing or management UI
- Data backup or restore functionality
