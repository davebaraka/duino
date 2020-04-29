import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothProvider with ChangeNotifier {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice bluetoothDevice;
  BluetoothDevice candidateDevice;
  List<BluetoothService> services;
  ConnectionStatus status = ConnectionStatus.NONE;
  StreamSubscription<BluetoothDeviceState> deviceSubscription;
  StreamSubscription<BluetoothState> bluetoothSubscription;
  BluetoothState bluetoothState = BluetoothState.on;

  void subscribeBluetooth() {
    bluetoothSubscription = flutterBlue.state.listen((onData) {
      if (onData != BluetoothState.on) {
        try {
          disconnectDevice();
        } catch (e) {
          print(e);
        }
        status = ConnectionStatus.NONE;
      }
      bluetoothState = onData;
      notifyListeners();
    });
  }

  Future<void> cancelBluetooth() async {
    await bluetoothSubscription.cancel();
  }

  void _subscribe() {
    deviceSubscription = bluetoothDevice.state.listen((onData) {
      if (onData == BluetoothDeviceState.connected) {
        status = ConnectionStatus.CONNECTED;
        notifyListeners();
      } else if (onData == BluetoothDeviceState.disconnected) {
        status = ConnectionStatus.NONE;
        notifyListeners();
      } else if (onData == BluetoothDeviceState.connecting) {
        status = ConnectionStatus.CONNECTING;
        notifyListeners();
      } else if (onData == BluetoothDeviceState.disconnecting) {
        status = ConnectionStatus.DISCONNECTING;
        notifyListeners();
      }
    });
  }

  Future<List<BluetoothDevice>> scanForDevices() async {
    List<BluetoothDevice> devices = [];
    List<ScanResult> scanResults;
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      scanResults = results;
    });
    await Future.delayed(Duration(seconds: 4));
    flutterBlue.stopScan();
    scanResults.forEach((result) => devices.add(result.device));
    return devices;
  }

  Future<void> disconnectDevice() async {
    if (bluetoothDevice != null) {
      await deviceSubscription.cancel();
      await bluetoothDevice.disconnect().timeout(Duration(seconds: 10));
      bluetoothDevice = null;
    }
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    status = ConnectionStatus.CONNECTING;
    candidateDevice = device;
    try {
      notifyListeners();
      await disconnectDevice();
      await device.connect().timeout(Duration(seconds: 10),
          onTimeout: () async {
        await bluetoothDevice.disconnect();
        throw (TimeoutException);
      });
      bluetoothDevice = device;
      services = await device.discoverServices();
      _subscribe();
      status = ConnectionStatus.CONNECTED;
      notifyListeners();
    } catch (e) {
      status = ConnectionStatus.ERRORCONNECTING;
      notifyListeners();
    }
  }

  void write(String data) {
    if (ConnectionStatus.CONNECTED == status) {
      var characteristics = services[0].characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.properties.writeWithoutResponse) {
          c.write(utf8.encode(data), withoutResponse: true);
        }
      }
    }
  }

  void notify() => notifyListeners();
}

enum ConnectionStatus {
  CONNECTED,
  CONNECTING,
  NONE,
  ERRORCONNECTING,
  DISCONNECTING,
  ERRORDISCONNECTING
}
