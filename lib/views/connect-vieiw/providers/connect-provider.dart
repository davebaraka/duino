import 'package:duino/providers/bluetooth-provider.dart';
import 'package:duino/views/connect-vieiw/components/device-component.dart';
import 'package:duino/views/connect-vieiw/components/nodevice-component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class ConnectProvider with ChangeNotifier {
  List<Widget> devices = [
    NoDeviceComponent(
      message: 'Discovered devices will be shown here.',
    )
  ];
  bool searching = false;

  Future<void> scan(context) async {
    if (!searching)
    try {
      searching = true;
      notifyListeners();
      List<BluetoothDevice> bluetoothDevices =
          await Provider.of<BluetoothProvider>(context, listen: false)
              .scanForDevices();
      devices = [];
      bluetoothDevices
          .forEach((device) => devices.add(DeviceComponent(device: device)));
      if (devices.length == 0) {
       BluetoothState state = Provider.of<BluetoothProvider>(context, listen: false).bluetoothState;
      String message = "No devices discovered.";
      switch (state) {
        case BluetoothState.unauthorized:
          message = 'Bluetooth permission denied. Please go to your device\'s settings and allow \'Duino\' to access bluetooh';
          break;
        case BluetoothState.unavailable:
          message = 'Sorry, your device does not have bluetooth.';
          break;
        case BluetoothState.unknown:
          message = 'Please make sure bluetooth is on and you have allowed \'Duino\' to access bluetooh in your device\'s settings.';
          break;
        case BluetoothState.off:
          message = 'Please turn on your device\'s bluetooth.';
          break;
        default:
          break;
      }
        devices = [
          NoDeviceComponent(
            message: message
          )
        ];
      }
      searching = false;
      notifyListeners();
    } catch (e) {
      devices = [
        NoDeviceComponent(
          message:
              'Sorry, there was an error fetching devices. Pleast try again.',
        )
      ];
      searching = false;
      notifyListeners();
    }
  }
}
