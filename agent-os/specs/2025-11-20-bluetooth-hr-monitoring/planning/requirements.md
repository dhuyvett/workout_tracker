# Spec Requirements: Bluetooth Heart Rate Monitoring with Real-Time Display

## Initial Description
Bluetooth heart rate monitoring with real-time display

**Product Context:**
- Flutter workout tracking application
- Privacy-first, offline-only (no cloud uploads, minimal permissions)
- Simple and focused design philosophy
- Local-only data storage with CSV export capability
- Must work fully offline without network connection
- No PII in data

**Tech Stack:**
- Flutter SDK ^3.10.0
- State management: Riverpod (recommended) or Provider
- Database: Sqflite with encryption support
- Bluetooth: flutter_blue_plus for BLE connectivity
- Charting: fl_chart for visualization
- Data export: csv package

## Requirements Discussion

### First Round Questions

**Q1: Device Discovery UX**
When a user opens the app for the first time (or when no device is connected), what should the experience be?

**Answer:** When the app starts, it should open to a page that allows the user to select and connect a bluetooth device.

---

**Q2: Real-Time Display Design**
For the main heart rate display during a workout, what information should be shown?

**Answer:** The main display should include a line chart of the previous (configurable but default to 30) seconds, but the primary feature should be a color-coded display of the current reading easily readable from a distance.

---

**Q3: Connection Management**
If a heart rate monitor unexpectedly disconnects during a workout, how should the app respond?

**Answer:** If a device unexpectedly disconnects, the app should display a message and attempt to reconnect up to 10 times.

---

**Q4: Data Recording Behavior**
Should heart rate data be recorded automatically when a device is connected, or should there be explicit "Start Workout" / "Stop Workout" controls?

**Answer:** Data should be recorded continuously.

---

**Q5: Sampling Rate**
How frequently should the app record heart rate readings to the database?

**Answer:** Every 1-2 seconds is sufficient.

---

**Q6: Error Handling**
When errors occur (permissions denied, Bluetooth disabled, device not compatible), what level of detail should error messages provide?

**Answer:** If anything prevents the app from getting data, it should display a message with as much context as possible and wait for user action. One exception is unexpected bluetooth disconnections which the app should retry the connection automatically. The error messages should be simple and user-focused, not overly technical.

---

**Q7: Testing Without Physical Device**
For development and testing purposes, should there be a demo/mock mode that simulates heart rate data?

**Answer:** There should be a demo mode.

---

**Q8: Device Compatibility**
Should the app support only generic BLE Heart Rate Service (0x180D) compatibility, or are there specific brands/models to prioritize?

**Answer:** Generic BLE Heart Rate Service (0x180D) compatibility.

---

**Q9: Workout Session Context**
Should the app include any session metadata beyond heart rate data?

**Answer:** Add basic session info.

---

**Q10: Permissions and User Consent**
How should the app handle requesting Bluetooth permissions from the user?

**Answer:** Show an explanation screen describing why Bluetooth access is needed.

---

**Q11: Out of Scope**
What features should explicitly NOT be included in this initial implementation?

**Answer:** Do not add advanced features unless they are specifically requested. The focus of the app is simplicity.

---

### Existing Code to Reference

No similar existing features identified for reference. This is the initial feature for the workout tracking application.

### Follow-up Questions

**Follow-up 1: Session Information Details**
You mentioned adding "basic session info." What specific information should be included in session metadata?

**Answer:** Duration, average heart rate, min heart rate, and max heart rate.

---

**Follow-up 2: Heart Rate Color Zones**
You mentioned a "color-coded display of the current reading." What heart rate zones and colors should be used?

**Answer:** Allow the user to enter their age, and set the ranges based on a calculation using the methodology found at Hopkins Medicine (Understanding Your Target Heart Rate).

**Heart Rate Zone Calculation Methodology:**
The standard Hopkins Medicine methodology for calculating target heart rate zones is:

1. **Maximum Heart Rate Calculation:**
   - Maximum HR = 220 - age

2. **Heart Rate Zones (as percentages of Maximum HR):**
   - **Zone 1 - Resting/Very Light (50-60% of max HR):** Light activity, warm-up, cool-down
   - **Zone 2 - Light (60-70% of max HR):** Fat burning, endurance base building
   - **Zone 3 - Moderate (70-80% of max HR):** Aerobic fitness, cardiovascular improvement
   - **Zone 4 - Hard/Vigorous (80-90% of max HR):** Anaerobic threshold, performance improvement
   - **Zone 5 - Maximum (90-100% of max HR):** Maximum effort, short bursts only

3. **Color Coding Scheme:**
   - Zone 1 (50-60%): Gray or Light Blue
   - Zone 2 (60-70%): Green
   - Zone 3 (70-80%): Yellow
   - Zone 4 (80-90%): Orange
   - Zone 5 (90-100%): Red
   - Below Zone 1 (<50%): Blue (resting)

**Example Calculation for a 30-year-old:**
- Max HR = 220 - 30 = 190 BPM
- Zone 1: 95-114 BPM
- Zone 2: 114-133 BPM
- Zone 3: 133-152 BPM
- Zone 4: 152-171 BPM
- Zone 5: 171-190 BPM

---

**Follow-up 3: Chart Time Window Configuration**
You mentioned the line chart should show the previous 30 seconds (configurable). Where should this configuration be accessible?

**Answer:** Settings screen. The expectation is that the default will be good for most.

---

**Follow-up 4: Reconnection Failure Handling**
After 10 failed reconnection attempts, what should happen?

**Answer:** Show a message with options to retry or to select another connection.

---

**Follow-up 5: Demo Mode Access**
How should demo mode be accessed?

**Answer:** There should be a "demo mode" device in the connection page device listing.

---

**Follow-up 6: Continuous Recording Details**
You mentioned data should be recorded continuously. Does this mean recording starts automatically as soon as a device is connected, and should there be any way to segment recordings?

**Answer:** All available data is recorded. The user will be able to segment the view of the data when we get to graphing and export.

---

## Visual Assets

### Files Provided:
No visual files found in the visuals folder.

### Visual Insights:
No visual assets provided.

## Requirements Summary

### Functional Requirements

#### Device Discovery & Connection
- App opens to a device selection/connection screen on startup when no device is connected
- Scan for and display available BLE heart rate monitors
- Support generic BLE Heart Rate Service (0x180D)
- Include a "Demo Mode" device option in the device listing for testing
- Save device preferences for quick reconnection

#### Real-Time Heart Rate Display
- Large, color-coded current heart rate reading (distance-readable)
- Color zones calculated based on user's age using Hopkins Medicine methodology:
  - User enters their age in app settings
  - Max HR = 220 - age
  - Zone 1 (50-60% max): Gray/Light Blue
  - Zone 2 (60-70% max): Green
  - Zone 3 (70-80% max): Yellow
  - Zone 4 (80-90% max): Orange
  - Zone 5 (90-100% max): Red
  - Below 50% max: Blue (resting)
- Line chart showing previous 30 seconds of data (default)
- Chart time window configurable in settings screen
- Connection status indicator
- Session information display:
  - Session duration
  - Average heart rate
  - Minimum heart rate
  - Maximum heart rate

#### Data Recording
- Continuous recording automatically starts when device is connected
- Recording stops when device is disconnected
- Sampling rate: every 1-2 seconds
- Local database storage (Sqflite with encryption)
- All available data is recorded continuously
- Users can segment the view of data later during graphing and export
- Session metadata captured:
  - Start timestamp
  - End timestamp
  - Duration
  - Average HR
  - Min HR
  - Max HR

#### Connection Management
- Auto-reconnect on unexpected disconnection (up to 10 attempts)
- Display reconnection status to user during attempts
- After 10 failed attempts: Show message with options to:
  - Retry connection
  - Select another device
- Save most recently connected device for quick reconnection

#### Error Handling & Permissions
- Permission explanation screen before requesting Bluetooth access
- Explain why Bluetooth access is needed (to connect to heart rate monitors)
- User-focused, simple error messages with context
- Provide as much context as possible when errors occur
- Automatic retry for connection issues only
- Manual user action required for other errors (permissions, Bluetooth disabled, etc.)

#### Demo Mode
- "Demo Mode" device appears in the connection page device listing
- Simulated heart rate data for testing without physical device
- Demo data should simulate realistic heart rate patterns and variability

#### Settings & Configuration
- Age input for heart rate zone calculation
- Chart time window configuration (default: 30 seconds)
- Saved device preferences
- Settings accessible from main app navigation

### Reusability Opportunities
No existing features to reuse. This is the foundational feature for the workout tracking app.

### Scope Boundaries

**In Scope:**
- Bluetooth heart rate monitor discovery and connection
- Real-time heart rate display with age-based color zones (Hopkins Medicine methodology)
- Line chart visualization of recent data (configurable time window)
- Continuous data recording to local encrypted database
- Auto-reconnection with retry logic and failure handling
- Permission explanation and error handling
- Demo mode accessible from device listing
- Session metadata (duration, avg/min/max HR)
- Settings screen for age and chart configuration
- Device preference persistence

**Out of Scope:**
- Manual start/stop workout controls (data records continuously)
- Session segmentation UI (handled in future graphing/export feature)
- GPS tracking (future roadmap item)
- Social features or sharing
- Cloud sync or backup
- Complex analytics or trends beyond basic session stats
- Advanced workout planning
- Integration with third-party services
- Multiple simultaneous device connections
- Historical data visualization (future roadmap item)
- Calorie calculation
- Heart rate variability (HRV) metrics
- Workout notes or session naming

### Technical Considerations

**Privacy-First Architecture:**
- All data stored locally only
- No network calls whatsoever
- Encrypted database (Sqflite with encryption)
- No PII in stored data

**Offline-Only:**
- Must work without network connection
- All features functional offline

**Permissions:**
- Bluetooth permissions (required)
- Location permissions on Android (required for BLE scanning by OS)
- No other permissions requested

**Flutter Platform:**
- Cross-platform support (Android, iOS, Linux, macOS, Windows)
- Material Design UI
- Responsive layouts

**State Management:**
- Riverpod recommended for managing:
  - BLE connection state
  - Real-time heart rate data streams
  - Recording state
  - Settings and preferences

**BLE Implementation:**
- flutter_blue_plus library for device communication
- Standard BLE Heart Rate Service (0x180D)
- Heart Rate Measurement characteristic (0x2A37)
- Handle connection state changes
- Implement retry logic with exponential backoff

**Charting:**
- fl_chart library for line graph visualization
- Real-time data updates
- Configurable time window
- Smooth scrolling/updating

**Database Schema:**
- Encrypted Sqflite database
- Tables needed:
  - heart_rate_readings (timestamp, bpm, session_id)
  - sessions (id, start_time, end_time, device_name, avg_hr, min_hr, max_hr)
  - settings (key, value) for user age and preferences
- Efficient querying for recent data window

**Demo Mode:**
- Simulate realistic heart rate patterns
- Generate data at 1-2 second intervals
- Include natural variability
- Simulate occasional connection state changes

### Similar Code Patterns to Follow

This is the first feature implementation. Future specifications should reference this feature's patterns for:
- BLE device connection management
- Real-time data display architecture
- Local database schema design
- Error handling approach
- Permission request flow
- Settings screen implementation
- State management with Riverpod
- Continuous background data recording
