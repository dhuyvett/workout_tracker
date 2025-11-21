import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scanned_device.dart';
import '../services/bluetooth_service.dart';

/// Provider for Bluetooth device scanning.
///
/// Streams a list of discovered devices that advertise the Heart Rate Service.
/// The demo mode device is always included in the list, even if scanning fails.
/// The demo device is emitted immediately to avoid loading spinners.
final deviceScanProvider = StreamProvider<List<ScannedDevice>>((ref) async* {
  final bluetoothService = BluetoothService.instance;

  // Always include demo mode device as first item
  final demoDevice = ScannedDevice.demoMode();

  // Emit demo device immediately so UI doesn't show loading spinner
  yield [demoDevice];

  try {
    // Start scanning for real devices
    await for (final devices in bluetoothService.scanForDevices()) {
      // Convert Bluetooth devices to ScannedDevice models
      final scannedDevices = devices.map((device) {
        return ScannedDevice(
          id: device.remoteId.str,
          name: device.platformName.isNotEmpty
              ? device.platformName
              : 'Unknown Device',
          rssi: 0, // RSSI will be updated from scan results if available
          isDemo: false,
        );
      }).toList();

      // Prepend demo device to the list
      yield [demoDevice, ...scannedDevices];
    }
  } on StateError catch (e) {
    // If Bluetooth is unavailable or off, log the error
    // Demo device is already shown, so just log and continue
    // ignore: avoid_print
    print('Bluetooth scanning error: $e');
  } catch (e) {
    // For other errors, log but don't crash
    // Demo device is already shown
    // ignore: avoid_print
    print('Unexpected error during device scanning: $e');
  }
});
