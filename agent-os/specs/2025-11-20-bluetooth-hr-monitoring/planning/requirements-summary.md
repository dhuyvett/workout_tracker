# Requirements Gathering Summary

## Bluetooth Heart Rate Monitoring Feature

**Specification Path:** `/home/ddhuyvetter/src/workout_tracker/agent-os/specs/2025-11-20-bluetooth-hr-monitoring/`

**Date:** 2025-11-20

---

## Key Decisions Made

### 1. User Experience Flow

**Decision:** App opens directly to device selection screen when no device is connected.

**Rationale:** Simplifies the initial user experience. Users expect to connect a device immediately when opening a workout tracking app.

**Impact:** No complex onboarding flow needed. Single-purpose app design reinforced.

---

### 2. Heart Rate Zone Calculation

**Decision:** Use Hopkins Medicine methodology with age-based calculation.

**Formula:**
- Maximum HR = 220 - age
- 5 zones based on percentage of max HR (50-60%, 60-70%, 70-80%, 80-90%, 90-100%)

**Color Scheme:**
- Resting (<50%): Blue
- Zone 1 (50-60%): Gray/Light Blue
- Zone 2 (60-70%): Green
- Zone 3 (70-80%): Yellow
- Zone 4 (80-90%): Orange
- Zone 5 (90-100%): Red

**Rationale:** Widely-recognized, medically-backed methodology. Simple age-based calculation requires minimal user input.

**Impact:**
- Settings screen must include age input
- Heart rate zone boundaries calculated dynamically
- Color coding provides instant visual feedback on exercise intensity

---

### 3. Continuous Recording Model

**Decision:** Data records automatically and continuously when device is connected. No manual start/stop controls.

**Rationale:** Simplifies user interaction. Aligns with "always-on" monitoring use case. Users can segment data later during analysis.

**Impact:**
- Reduced UI complexity (no workout control buttons on main screen)
- All data preserved for later analysis
- Session segmentation deferred to future graphing/export feature
- Database must efficiently handle continuous data streams

---

### 4. Demo Mode Integration

**Decision:** Demo mode appears as a selectable "device" in the device listing, not hidden in settings.

**Rationale:** Makes demo mode discoverable and easy to use for testing. Treats demo as a first-class connection option.

**Impact:**
- Device listing UI must include synthetic demo device
- Demo mode must simulate realistic HR patterns
- No separate developer menu needed

---

### 5. Reconnection Strategy

**Decision:** Automatic retry up to 10 attempts, then present user with manual options (retry or select different device).

**Rationale:** Balance between persistence (don't lose workout data) and user control (don't frustrate user with endless failed attempts).

**Impact:**
- Requires retry counter in connection state
- UI must show reconnection progress
- After failure, provide clear action options

---

### 6. Session Metadata Scope

**Decision:** Track duration, average HR, minimum HR, and maximum HR only. No calorie estimation, HRV, or other advanced metrics.

**Rationale:** Keeps implementation simple. Core metrics sufficient for basic workout tracking. Aligns with product's simplicity philosophy.

**Impact:**
- Database schema simplified
- Calculation logic straightforward
- No need for complex algorithms or user profile data beyond age

---

### 7. Chart Configuration Location

**Decision:** Time window configuration accessible in settings screen, not on main display.

**Rationale:** Default of 30 seconds expected to work for most users. Settings screen appropriate for infrequently-changed preferences. Keeps main display clean.

**Impact:**
- Settings screen must include chart time window option
- Main display UI simplified (no time window toggle buttons)
- Default value (30s) must be sensible

---

### 8. Privacy & Offline Architecture

**Decision:** Strict offline-only operation with encrypted local database. No network calls whatsoever.

**Rationale:** Privacy-first product philosophy. No need for cloud features. Simplifies permission model.

**Impact:**
- No network permission requests
- All features must work without connectivity
- Local storage is single source of truth
- Export functionality critical for data portability

---

### 9. Bluetooth Compatibility

**Decision:** Support only standard BLE Heart Rate Service (0x180D), not proprietary protocols.

**Rationale:** Maximizes device compatibility. Avoids vendor lock-in. Standard service widely supported.

**Impact:**
- No vendor-specific implementations needed
- Broader device compatibility
- Clear documentation reference (Bluetooth SIG specification)

---

### 10. Error Handling Philosophy

**Decision:** Simple, user-focused messages with context. Automatic retry only for connection issues. Manual action required for other errors.

**Rationale:** Balance between automation and user control. Connection issues are transient; other errors typically require user intervention.

**Impact:**
- Error messages must explain problem clearly without technical jargon
- Different error types handled with appropriate strategies
- Permission explanation screen required before Bluetooth access

---

## Requirements Completeness Verification

### Answered Questions

**Initial Round (11 questions):**
1. Device Discovery UX - ANSWERED
2. Real-Time Display Design - ANSWERED
3. Connection Management - ANSWERED
4. Data Recording Behavior - ANSWERED
5. Sampling Rate - ANSWERED
6. Error Handling - ANSWERED
7. Testing Without Physical Device - ANSWERED
8. Device Compatibility - ANSWERED
9. Workout Session Context - ANSWERED
10. Permissions and User Consent - ANSWERED
11. Out of Scope - ANSWERED

**Follow-up Round (6 questions):**
1. Session Information Details - ANSWERED
2. Heart Rate Color Zones - ANSWERED (with calculation methodology)
3. Chart Time Window Configuration - ANSWERED
4. Reconnection Failure Handling - ANSWERED
5. Demo Mode Access - ANSWERED
6. Continuous Recording Details - ANSWERED

**Total:** 17/17 questions answered (100% complete)

---

## Scope Clarity

### Clearly In Scope
- BLE device discovery and connection
- Real-time heart rate display with color zones
- Line chart visualization (configurable time window)
- Continuous data recording
- Auto-reconnection with failure handling
- Demo mode
- Basic session metadata
- Settings screen (age, chart config)
- Permission explanations

### Clearly Out of Scope
- Manual workout start/stop controls
- Session segmentation UI (future feature)
- GPS tracking
- Social features
- Cloud sync
- Complex analytics
- Calorie estimation
- Heart rate variability (HRV)
- Workout notes

### Deferred to Future
- Data segmentation viewing (during graphing/export)
- Historical data visualization
- Advanced workout features

---

## Technical Architecture Clarity

### Database Schema
**Defined:**
- heart_rate_readings table (timestamp, bpm, session_id)
- sessions table (id, start_time, end_time, device_name, avg_hr, min_hr, max_hr)
- settings table (key-value for age and preferences)

### State Management
**Defined:**
- Riverpod for BLE connection state, HR data streams, recording state, settings

### Libraries
**Defined:**
- flutter_blue_plus (BLE)
- fl_chart (visualization)
- sqflite (encrypted database)
- csv (future export)

### BLE Implementation
**Defined:**
- Heart Rate Service UUID: 0x180D
- Heart Rate Measurement characteristic: 0x2A37
- Retry logic with exponential backoff
- Connection state handling

---

## Unambiguous Requirements Status

**All requirements are now unambiguous and ready for specification writing.**

### Evidence:
1. UX flows clearly defined (device selection → connection → monitoring)
2. Visual design specified (color zones with exact calculations)
3. Data model defined (tables, fields, relationships)
4. Behavior specified (auto-record, auto-reconnect, error handling)
5. Configuration options identified (age, chart window)
6. Technical stack selected (specific libraries and versions)
7. Scope boundaries explicit (in/out/deferred)

### No Remaining Ambiguities:
- No vague terms like "basic info" (now specified as duration, avg/min/max HR)
- No unclear UX flows (all screens and transitions defined)
- No missing technical details (libraries, schemas, calculations specified)
- No scope confusion (clear in/out boundaries)

---

## Readiness for Specification Writing

**STATUS: READY**

The requirements gathering phase is complete. All necessary information has been collected to write a comprehensive technical specification including:

- User stories and use cases
- Screen-by-screen UI specifications
- Data models and database schema
- State management architecture
- BLE communication protocols
- Error handling strategies
- Testing requirements (demo mode)
- Settings and configuration

The spec writer can now proceed with creating the formal specification document without needing additional clarifications from the user.
