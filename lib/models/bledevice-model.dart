import 'package:collection/collection.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

/// Based on https://github.com/Polidea/FlutterBleLib/blob/develop/example/lib/model/ble_device.dart.
class BleDevice {
  final Peripheral peripheral;
  final String name;
  final DeviceCategory category;
  Characteristic characteristic;

  String get id => peripheral.identifier;

  BleDevice(ScanResult scanResult)
      : peripheral = scanResult.peripheral,
        name = scanResult.name != "" ? scanResult.name : '(Unknown)',
        category = scanResult.category;

  /// Gets the Service with FFE0 and characteristic with FFE1
  /// This is defined in DSD Tech User Guide for HM-10
  Future<void> setCharacteristic() async {
    await peripheral.discoverAllServicesAndCharacteristics();
    List<Service> services = await peripheral.services();
    Service service = services.firstWhere(
        (element) => element.uuid.toLowerCase().startsWith(RegExp(r'0*ffe0')));
    List<Characteristic> characteristics = await service.characteristics();
    characteristic = characteristics.firstWhere(
        (element) => element.uuid.toLowerCase().startsWith(RegExp(r'0*ffe1')));
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(other) =>
      other is BleDevice &&
      this.name != null &&
      other.name != null &&
      compareAsciiLowerCase(this.name, other.name) == 0 &&
      this.id == other.id;

  @override
  String toString() {
    return 'BleDevice{name: $name}';
  }
}

enum DeviceCategory { sensorTag, hex, other }

extension on ScanResult {
  String get name =>
      peripheral.name ?? advertisementData.localName ?? "Unknown";

  DeviceCategory get category {
    if (name == "SensorTag") {
      return DeviceCategory.sensorTag;
    } else if (name != null && name.startsWith("Hex")) {
      return DeviceCategory.hex;
    } else {
      return DeviceCategory.other;
    }
  }
}
