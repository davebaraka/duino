import 'dart:async';
import 'dart:convert';

import 'package:duino/models/bledevice-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

/// Entry point for all bluetooth functionality.
class BluetoothProvider with ChangeNotifier {
  final BleManager bleManager = BleManager();

  BleDevice bleDevice;
  StreamSubscription<PeripheralConnectionState> deviceStateSubscription;
  StreamSubscription<BluetoothState> bluetoothStateSubscription;
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  PeripheralConnectionState bleDeviceState =
      PeripheralConnectionState.disconnected;
  bool _mounted = true;

  /// Starts bluetooth services.
  Future<void> startBluetooth() async {
    try {
      await bleManager.createClient();
      bluetoothStateSubscription =
          bleManager.observeBluetoothState().listen((btState) {
        bluetoothState = btState;
        switch (btState) {
          case BluetoothState.POWERED_OFF:
            bleDevice = null;
            break;
          case BluetoothState.RESETTING:
            bleDevice = null;
            break;
          case BluetoothState.UNAUTHORIZED:
            bleDevice = null;
            break;
          case BluetoothState.UNSUPPORTED:
            bleDevice = null;
            break;
          default:
        }
        notify();
      }, onError: (e) {
        print(e);
        bluetoothState = BluetoothState.UNKNOWN;
        notify();
      });
    } catch (e) {
      print(e);
      bluetoothState = BluetoothState.UNKNOWN;
    }
  }

  /// Connects to a bluetooth device
  Future<void> connect(BleDevice device) async {
    try {
      await disconnect();
      bleDevice = device;
      bleDeviceState = PeripheralConnectionState.connecting;
      notify();
      await device.peripheral.connect(timeout: Duration(seconds: 8));
      await device.peripheral
          .discoverAllServicesAndCharacteristics()
          .timeout(Duration(seconds: 8));
      await device.setCharacteristic();
      bleDeviceState = PeripheralConnectionState.connected;
      deviceStateSubscription = device.peripheral
          .observeConnectionState(
              completeOnDisconnect: true, emitCurrentValue: true)
          .listen((connectionState) {
        bleDeviceState = connectionState;
        notify();
      }, onError: (e) {
        print(e);
      }, onDone: () => bleDevice = null);
      notify();
    } catch (e) {
      print(e);
      disconnect();
      bleDeviceState = PeripheralConnectionState.disconnected;
      notify();
    }
  }

  /// Disconnects a bluetooth device.
  Future<void> disconnect() async {
    bleDeviceState = PeripheralConnectionState.disconnecting;
    notify();
    try {
      if (bleDevice != null)
        await bleDevice.peripheral
            .disconnectOrCancelConnection()
            .timeout(Duration(seconds: 8));
      if (deviceStateSubscription != null)
        await deviceStateSubscription.cancel().timeout(Duration(seconds: 4));
      bleDevice = null;
    } catch (e) {
      print(e);
    }
    bleDeviceState = PeripheralConnectionState.disconnected;
    notify();
  }

  /// Write to bluetooth characteristic.
  void write(String data) {
    if ((bluetoothState == BluetoothState.POWERED_ON ||
            bluetoothState == BluetoothState.UNKNOWN) &&
        bleDeviceState == PeripheralConnectionState.connected) {
      if (bleDevice.characteristic.isWritableWithoutResponse) {
        bleDevice.characteristic
            .write(utf8.encode(data), false)
            .catchError((e) => print(e));
      }
    }
  }

  /// Notify Listeners
  void notify() => _mounted ? notifyListeners() : null;

  @override
  void dispose() async {
    _mounted = false;
    await bluetoothStateSubscription.cancel();
    await bleManager.destroyClient();
    super.dispose();
  }
}
