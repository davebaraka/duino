import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:duino/models/bledevice-model.dart';
import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/views/connect-vieiw/components/device-component.dart';
import 'package:duino/views/connect-vieiw/components/nodevice-component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectProvider extends ChangeNotifier {
  StreamSubscription<ScanResult> scanSubscription;
  StreamSubscription<void> scanningSubscription;
  bool isScanning = false;
  bool _mounted = true;
  BleManager bleManager;
  List<Widget> widgets = [
    NoDeviceComponent(
      showDefaultMessage: true,
    )
  ];

  /// Scan for bluetooth devices.
  Future<void> startScan(BluetoothProvider bluetoothProvider) async {
    bleManager = bluetoothProvider.bleManager;
    if (!isScanning &&
        (bluetoothProvider.bluetoothState == BluetoothState.POWERED_ON ||
            bluetoothProvider.bluetoothState == BluetoothState.UNKNOWN)) {
      try {
        isScanning = true;
        widgets.clear();
        widgets = [NoDeviceComponent()];
        notify();
        List<BleDevice> bleDevices = [];
        await _checkPermissions();
        scanSubscription = bluetoothProvider.bleManager
            .startPeripheralScan()
            .listen((scanResult) {
          BleDevice bleDevice = BleDevice(scanResult);
          if (scanResult.advertisementData.localName != null &&
              !bleDevices.contains(bleDevice)) {
            if (bleDevices.isEmpty) widgets.clear();
            bleDevices.add(bleDevice);
            widgets.add(DeviceComponent(bleDevice: bleDevice));
            notify();
          }
        }, onError: (e) async {
          print(e);
          await _cancelScan();
        });

        scanningSubscription = Future.delayed(Duration(seconds: 8), () async {
          await _cancelScan();
          if (bleDevices.isEmpty) widgets = [NoDeviceComponent()];
          isScanning = false;
          notify();
        }).asStream().listen((onData) {});
      } catch (e) {
        _cancelScan();
        widgets = [
          NoDeviceComponent(
            showAndroidMessage: true,
          )
        ];
        isScanning = false;
        notify();
      }
    } else if (!isScanning &&
        bluetoothProvider.bluetoothState != BluetoothState.POWERED_ON &&
        bluetoothProvider.bluetoothState != BluetoothState.UNKNOWN) {
      widgets = [NoDeviceComponent()];
      isScanning = false;
      notify();
    }
  }

  /// Cancel scan and clean up.
  Future<void> _cancelScan() async {
    try {
      if (scanSubscription != null) await scanSubscription.cancel();
      if (bleManager != null) await bleManager.stopPeripheralScan();
      if (scanningSubscription != null) await scanningSubscription.cancel();
    } catch (e) {
      print(e);
    }
  }

  /// Android only. Based on documentation.
  /// We can only check runtime permissions on Android 6.0 and later
  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo =
          await DeviceInfoPlugin().androidInfo.catchError((e) => print(e));
      if (androidInfo != null && androidInfo.version.sdkInt < 23) {
        return;
      }
      if (!await Permission.location.request().isGranted) {
        return Future.error(Exception("Location permission not granted"));
      }
    }
  }

  /// Notify listeners based on state.
  void notify() => _mounted ? notifyListeners() : null;

  @override
  void dispose() {
    _mounted = false;
    _cancelScan();
    super.dispose();
  }
}
