<h1 align="center">
  <br>
  <img src="https://github.com/davebaraka/duino/blob/master/assets/git/featured.png" width="50%" height="25%" title="Duino Logo">
   <br>
    Duino v0.0.1
   <br>
</h1>

<p>
Control an arduino using your phone's bluetooth. Duino is available on both <a href="https://apps.apple.com/us/app/duino/id1511212791" target="_blank">iOS</a> and <a href="https://play.google.com/store/apps/details?id=dev.duino&hl=en_US" target="_blank">android</a> featuring buttons, d-pad, joystick, and tilt pad to control your arduino. The possibiltes of these features are limited by your imagination. Duino was created as a project using a cross platform development framework, Flutter. One of the main goals of this project was to create a simple and modern user interface. Enjoy!
</p>

<p align="center">
  <br>
  <img src="https://github.com/davebaraka/duino/blob/master/assets/git/mockup.png" width="100%" height="100%" title="Mockup">
  <br>
</p>

<p align="center">
  <a href="https://apps.apple.com/us/app/duino/id1511212791" target="_blank"><img src="https://github.com/davebaraka/duino/blob/master/assets/git/app-store-badge.png" width="112.5" height="38" title="Apple App Store"></a>&nbsp; &nbsp; &nbsp;
  <a href="https://play.google.com/store/apps/details?id=dev.duino&hl=en_US" target="_blank"><img src="https://github.com/davebaraka/duino/blob/master/assets/git/google-play-badge.png" width="127" height="38" title="Google Play"></a>
</p>

## Getting Started

### Requirements

* Mobile device running at least iOS 8.0 or android 4.4
* [HM-10 Bluetooth 4.0 LE Module](https://www.amazon.com/gp/product/B074VXZ1XZ/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1)
* Arduino board (Ex. Arduino Uno)

Similar configurations and devices may work. Please read your device's documentation before continuing. The setup used in this guide includes an iPhone XR, an Arduino Uno, and a HM-10 bluetooth module. For more information, please see [Limitations](https://github.com/davebaraka/duino#limitations).

### Setup

Download the <a href="https://apps.apple.com/us/app/duino/id1511212791" target="_blank">iOS</a> or <a href="https://play.google.com/store/apps/details?id=dev.duino&hl=en_US" target="_blank">android</a> app.

Wire your Arduino Uno and HM-10 bluetooth module. See the circuit diagram below.

![Circuit Diagram](https://github.com/davebaraka/duino/blob/master/assets/git/circuit.png)

* The RX and TX pins are used for serial communication. The Arduino Uno (device to the left) features several pins that can be used for serial communiation through the [SoftwareSerial Library](https://www.arduino.cc/en/Reference/softwareSerial). Pins 0 and 1 on the arduino have built-in support for serial communication; however, these ports can interfere with the native serial communication. As a result, pins 10 and 11 are used in the diagram above, where pin 10 acts as RX and pin 11 acts as TX.

* The HM-10 bluetooth module (device to the right) has a working voltage support of 3.3V to 6V, but the logic level is **3.3V**.  If the logic level of your board is 5V, it is recommended that you use a voltage divider. In the diagram above, a 3.3V power source is used to power the bluetooth module.

Power your arduino and a LED on the bluetooth module should start to blink, indicating an unpaired state.

Open the Duino app and tap the 'Connect' button. Then tap 'Scan' in the connect screen. Tap on the bluetooth device, 'DSD TECH' in this case, and then tap 'Yes' to connect. The LED on the bluetooth module should stop blinking and maintain a solid glow, indicating your devices have successfully paired.

* Make sure you agree to allow Duino to access the bluetooth permission. For android users, you may need to allow Duino to access the location permission in order to successfully complete scans. For more information on why this permission is required, please read the [android documentation](https://developer.android.com/guide/topics/connectivity/bluetooth-le#permissions). For information on why iOS does not require the location permission, read [this](https://www.polidea.com/blog/a-curious-relationship-android-ble-and-location/#why-ios-is-different). **Duino does not collect or transmit personal data.**

### Hello World

Let's create a program for the arduino to read the raw data coming from Duino. Upload the following code to your arduino. Make sure you use the correct RX and TX pins. This example program is following the circuit diagram above. 

```C++
#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX | TX

void setup() {
  Serial.begin(9600);
  BTSerial.begin(9600);
  while (!Serial);
  Serial.println("DUINO: <ARDUINO READY>");
}

void loop() {
  if (BTSerial.available()) {
    Serial.write(BTSerial.read());
  }
}
```

Use the different features of Duino to see how the program reacts in the serial monitor.

You should see a long line of characters, after `DUINO: <ARDUINO READY>`. I will explain the bounds for the data received for each feature under [Features](https://github.com/davebaraka/duino#features).

[Here](https://github.com/davebaraka/duino/blob/master/assets/git/examples) is a simple program to turn the arduino built in LED on and off by pressing 1 and 0 on the keypad.

## Features

I've included example parsers for each feature in the Duino folder [here](https://github.com/davebaraka/duino/blob/master/assets/git/examples). The `Duino.ino` file contains all the parsers. Uncomment the parser you would like to use in the main loop.

Data received by Duino are ASCII characters delimted by a `#`.

### Keypad

Keypad inputs from Duino are digit characters ranging from `0 to 9` inclusive.

Duino registers keypad releases as a valid input. Long presses or canceled presses will not be registered. See D-pad for long press inputs.

### D-pad

D-pad inputs from Duino are alpha characters, either `N` `S` `E` or `W`.

Duino will emit one of the values while pressing a d-pad key, and then emit the delimeter on release.

### Joystick

Joystick inputs from Duino are characters that can be visualized as `degreedistance#`. The degree is the joystick angle, and the distance is the distance from the center. Both degree and distance contain three digit characters. For instance, you may get a stream of data like `000000#150255#355002#`, which is interpreted as `(0 degrees, 0 units)`, `(150 degrees, 255 units)`, and `(355 degrees, 2 units)`. Degrees range from `0 to 360` inclusive, while the units range from `0 to 255` inclusive.

Duino will emit a joystick value at least every `75ms` if the joystick changes position. You could change this [here](https://github.com/davebaraka/duino/blob/0f5fa6b23aba9bdd42250b2ee2da88cfd5525dc8/lib/views/joystick-view/joystick-view.dart#L48).

### Tilt Pad

Tilt pad inputs from Duino are characters that can be visualized as `rollpitch#`. The roll is the device rotation around the front-to-back axis in degrees, and the pitch is the device rotation around the side-to-side axis in degrees. Both roll and pitch contain four characters. These characters are digits and/or `-`. For instance, you may get a stream of data like `-0010090#01500072#-117-012#`, which is interpreted as `(-1 degrees, 90 degrees)`, `(150 degrees, 72 degrees)`, and `(-117 degrees, -12 degrees)`. The roll ranges from `-180 to 180` degrees inclusive, while the pitch ranges from `-90 to 90` inclusive.

Duino will emit a tilt pad value at least every `75ms`. You could change this [here](https://github.com/davebaraka/duino/blob/0f5fa6b23aba9bdd42250b2ee2da88cfd5525dc8/lib/views/tilt-view/components/ring-component.dart#L18).

For more information on how to read and parse serial data, see [this](https://forum.arduino.cc/index.php?topic=396450.0).

## Limitations

Duino does not support tablets or large screen devices. You can change and compile the code for these devices, but for design reasons, I decided not to include these devices.

Android devices that do not support bluetooth low energy will not be able to download Duino.

The bluetooth library used in the application only supports bluetooth low energy devices. There are other bluetooth libraries, ones that support bluetooth classic, though Duino focuses on relatively modern devices and protocols.

Bluetooth LE devices have a list services and each service has a list of charactericts that we can read, write, and notify. There is a lot more going on and you can read more about it [here](https://www.bluetooth.com/blog/a-developers-guide-to-bluetooth/). For the HM-10 bluetooth module, it just so happens that it has one service, and that service has one characteristic. Duino writes to this characteristic. If you are trying to connect a bluetooth device that has multiple services and or characteristics, Duino may not act properly, because it connects to the first characteristic of the first service as written [here](https://github.com/davebaraka/duino/blob/0f5fa6b23aba9bdd42250b2ee2da88cfd5525dc8/lib/models/bledevice-model.dart#L21).

The arduino has a limited buffer size to temporarily store serial data. For the joystick and tilt pad, I have set it to emit data at least every `75ms`. Even at `50ms`, the arduino is able to successfully capture all the incoming data. A program you write may take processing time that could overflow the buffer, and as a result you will miss data points. This is more of a concern for the joystick, as it does not continuously emit data. There are several ways this can be minimized or overcame. That's up to you. Currently, there is no way to adjust the delay in the app.

There may be a time (probably not if I did my job well) where the bluetooth module may be in the connected state, but Duino says that no device is connected. Simply, restart the application and/or duino, so that both devices disconnect and then pair again.

## Development

Flutter is used as the framework to develop both the iOS and android app. Flutter version 1.17.0 was used at the time of developemnt. If you decide to continue development and use a different version, you may need to migrate some files. You may also encounter some errors if flutter decides to download a third party version that has errors or is incompatible. A workaround would be to use the exact versions I used, so in [pubspec.yaml](https://github.com/davebaraka/duino/blob/master/pubspec.yaml#L33), where the third party libraries are defined, you could write something like this `provider: 4.0.5` instead of this `provider: ^4.0.5`, though this is not recommended.

App Architecture (Barebones)

* `lib/`: Where all the action happens. 
* `lib/components/`: Contains reusable components or widgets used throughout the application.
* `lib/models/`: Data models.
* `lib/providers/`: Scoped state management solution using [provider](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple). Used throughout the app.
* `lib/views/`: Code for each screen of the app.
* `lib/main.dart`: Entry point.
* `lib/routes.dart`: Navigation manager. Navigating between different screens.
* `lib/styles.dart`: Where all the dynamic and consistent colors and styles are defined.

My main focus for this application was to create a simple and easy-to-use interface. Flutter, being a UI-first framework, made the developemnt process significantly faster, where most of my efforts were focused on the design. I had prior experience using Flutter, so setting up the project as an expandable architecture was simple. My design process for the app went something like this:

* Research bluetooth devices, similar apps and ideas, connectivity interfaces
* Sketch a mockup design with pencil and paper.
* Attempt to build it.
* Realizing the engineering effort may be a bit much - Sketch again
* Attempt to build it.
* Realizing...
* Attempt to build it.
* Realizing...
* Attempt to build it.
* Test, publish, and document.

The app was intended to act more like virtual hardware that an arduino could use. That is why there isn't much feedback in the app when it comes to the emitted data from the application. For instance, when you use the tilt pad, there is no start or stop button and there is no way to see the data being sent on your mobile device. I was aiming for a plug and play interaction, where a user would focus their efforts on using the app as a tool and spend most of their time creating programs for the arduino. Additionally, when it comes to similar applications, Duino aims to be as transparent as possible. Duino does not rely on third party software on the arduino and Duino is open source. This gives users abosolute control on how to interpret the data and make desired modifications.

Some complications I encountered was with the math to interpret the roll and pitch from the acceleration data of the accelerometer. I still don't quite understand what's going on, but the values were consistent as I rotated my device. You can see the equations [here](https://github.com/davebaraka/duino/blob/0f5fa6b23aba9bdd42250b2ee2da88cfd5525dc8/lib/views/tilt-view/components/ring-component.dart#L63). I got them off of [stackoverflow](https://stackoverflow.com/questions/3755059/3d-accelerometer-calculate-the-orientation). Another difficulty was parsing the data for the arduino. I was unfamiliar with C++ and their use of arrays. My parsers may have some naive approaches in parsing a stream of characters.

## Contribute

Duino was developed as an academic project and I intend for this project to be more as an educational resource, learn by open sourcing. I am very open for feedback and contribution.

Adobe XD files and resources used to make the visual content are [here](https://github.com/davebaraka/duino/tree/master/assets/git).

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

To learn more about the HM-10 bluetooth module, see [this](http://blog.blecentral.com/2015/05/05/hm-10-peripheral/).

___

<sup>App Store® and Apple® logo are registered trademarks of Apple Inc.</sup>

<sup>Google Play and the Google Play logo are trademarks of Google LLC.</sup>
