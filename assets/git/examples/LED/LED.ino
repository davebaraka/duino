#include <SoftwareSerial.h>

SoftwareSerial BTSerial(10, 11); // RX | TX

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  BTSerial.begin(9600);
  while (!Serial);
  Serial.println("DUINO: <ARDUINO READY>");
}

void loop() {
  controlLED();
}

void controlLED() {
  boolean debug = true; // set this to false to hide debug output
  boolean newData = false; // true when newData is ready

  const byte numChars = 2; // number of characters for accepted data
  const char delimeter = '#'; // delimeter that separates unit of data
  char c; // current character

  char receivedChars[numChars];   // an array to store the received data
  static byte i = 0; // current index of array

  int var; // final value


  while (BTSerial.available() > 0 && newData == false) {

    c = BTSerial.read();

    if (c != delimeter) {
      if (isDigit(c)) {
        receivedChars[i] = c;
        i++;
      }
    }
    else {
      receivedChars[i] = '\0';
      var = strtol(receivedChars, NULL, 10);
      if (debug) {
        Serial.print("DUINO: Keypad Digit Pressed --> ");
        Serial.println(var);
      }
      i = 0;
      newData = true;
    }
  }

  if (newData) {
    if(var == 0) {
      digitalWrite(LED_BUILTIN, LOW);
    } else if (var == 1) {
      digitalWrite(LED_BUILTIN, HIGH);
    }
    newData = false;
  }
}
