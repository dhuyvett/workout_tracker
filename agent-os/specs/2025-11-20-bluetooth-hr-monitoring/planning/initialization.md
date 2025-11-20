# Feature Idea: Bluetooth Heart Rate Monitoring with Real-Time Display

## Date
2025-11-20

## Raw Description
Bluetooth heart rate monitoring with real-time display

## Product Context
- Flutter workout tracking application
- Privacy-first, offline-only (no cloud uploads, minimal permissions)
- Simple and focused design philosophy
- Local-only data storage with CSV export capability
- Must work fully offline without network connection
- No PII in data

## Tech Stack
- Flutter SDK ^3.10.0
- State management: Riverpod (recommended) or Provider
- Database: Sqflite with encryption support
- Bluetooth: flutter_blue_plus for BLE connectivity
- Charting: fl_chart for visualization
- Data export: csv package
