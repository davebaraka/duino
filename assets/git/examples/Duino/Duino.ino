/// Requried to set pins to receive data.
#include <SoftwareSerial.h>

/// Define your RX & TX arduino pins.
SoftwareSerial BTSerial(10, 11); // RX | TX

void setup() {
  Serial.begin(9600);
  BTSerial.begin(9600);
  while (!Serial);
  Serial.println("DUINO: <ARDUINO READY>");
}

void loop() {
  //parseKeypad();
  //parseDpad();
  //parseJoystick();
  //parseTiltPad();
}

/*
   Parses keypad inputs from Duino.

   The variable 'var' contains the desired value when newData is true.
   var = <int, ranging from 0-9 inclusive>

   For keypad inputs, Duino registers keypad releases as a valid input.
   Long presses or canceled presses will be unregistered.
   See D-pad for long press inputs.
*/
void parseKeypad() {
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
        if (i >= numChars) {
          if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
          if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
          while (BTSerial.available() > 0) {
            if ( BTSerial.read() == delimeter) {
              break;
            }
          }
          if (debug) Serial.println("DUINO: <ARDUINO READY>");
          i = 0; // reset static value
          break;
        }
      } else {
        if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
        if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
        while (BTSerial.available() > 0) {
          if ( BTSerial.read() == delimeter) {
            break;
          }
        }
        if (debug) Serial.println("DUINO: <ARDUINO READY>");
        i = 0; // reset static value
        break;
      }
    } else if (i < numChars - 1) {
      if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
      if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
      while (BTSerial.available() > 0) {
        if ( BTSerial.read() == delimeter) {
          break;
        }
      }
      if (debug) Serial.println("DUINO: <ARDUINO READY>");
      i = 0; // reset static value
      break;
    }
    else {
      receivedChars[i] = '\0'; // terminate the string (array of characters)
      var = strtol(receivedChars, NULL, 10); // convert array to int
      if (debug) {
        Serial.print("DUINO: Keypad Digit Pressed --> ");
        Serial.println(var);
      }
      i = 0; // reset static value
      newData = true;
    }
  }
}


/*
   Parses d-pad inputs from Duino.

   The variable 'var' contains the direction value when newData is true.
   var = < char, either 'N', 'S', 'E', or 'W'>

   The variable 'state' - pressed state of the button when newData is true.
   state = <boolean, true while pressed false otherwise>
*/
void parseDpad() {
  boolean debug = true; // set this to false to hide debug output
  boolean newData = false; // true when newData is ready

  const byte numChars = 2; // number of characters for accepted data
  const char delimeter = '#'; // delimeter that separates unit of data
  char c; // current character

  static char receivedChars[numChars];   // an array to store the received data
  static byte i = 0; // current index of array

  static char var; // direction value
  static boolean state = false; // pressing state value


  while (BTSerial.available() > 0 && newData == false) {

    c = BTSerial.read();

    if (c != delimeter) {
      if (isAlpha(c)) {
        receivedChars[i] = c;
        i++;
        state = true;
        var = c;
        newData = true;
        if (debug) {
          Serial.print("DUINO: D-pad Pressing --> ");
          Serial.println(var);
        }
        break;
      } else {
        if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
        if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
        while (BTSerial.available() > 0) {
          if ( BTSerial.read() == delimeter) {
            break;
          }
        }
        if (debug) Serial.println("DUINO: <ARDUINO READY>");
        state = false;
        i = 0; // reset static value
        break;

      }
    } else if (i < numChars - 1) {
      if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
      if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
      while (BTSerial.available() > 0) {
        if ( BTSerial.read() == delimeter) {
          break;
        }
      }
      if (debug) Serial.println("DUINO: <ARDUINO READY>");
      state = false;
      i = 0; // reset static value
      break;

    } else {
      receivedChars[i] = '\0'; // terminate the string (array of characters)
      if (debug) {
        Serial.print("DUINO: D-pad Released --> ");
        Serial.println(var);
      }
      state = false;
      i = 0; // reset static value
      newData = true;
    }

  }
}

/*
   Parses joystick inputs from Duino.

   The variable 'degree', joystick angle degree when newData is true.
   degree = <int, ranging from 0 to 360 inclusive>

   The variable 'distance', joystick distance from center when newData is true.
   distance = <int, ranging from 0 to 255 inclusive>
*/
void parseJoystick() {
  boolean debug = true; // set this to false to hide debug output
  boolean newData = false; // true when newData is ready

  const byte numChars = 7; // number of characters for accepted data
  const char delimeter = '#'; // delimeter that separates unit of data
  char c; // current character

  char receivedChars[numChars];   // an array to store the received data
  static byte i = 0; // current index of array

  int degree; // angle degree
  int distance; // distance from center


  while (BTSerial.available() > 0 && newData == false) {

    c = BTSerial.read();

    if (c != delimeter) {
      if (isDigit(c)) {
        receivedChars[i] = c;
        i++;
        if (i >= numChars) {
          if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
          if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
          while (BTSerial.available() > 0) {
            if ( BTSerial.read() == delimeter) {
              break;
            }
          }
          if (debug) Serial.println("DUINO: <ARDUINO READY>");
          i = 0; // reset static value
          break;
        }
      } else {
        if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
        if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
        while (BTSerial.available() > 0) {
          if ( BTSerial.read() == delimeter) {
            break;
          }
        }
        if (debug) Serial.println("DUINO: <ARDUINO READY>");
        i = 0; // reset static value
        break;
      }
    } else if (i < numChars - 1) {
      if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
      if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
      while (BTSerial.available() > 0) {
        if ( BTSerial.read() == delimeter) {
          break;
        }
      }
      if (debug) Serial.println("DUINO: <ARDUINO READY>");
      i = 0; // reset static value
      break;
    }
    else {
      receivedChars[i] = '\0'; // terminate the string (array of characters)

      char tmp[4];

      tmp[0] = receivedChars[0];
      tmp[1] = receivedChars[1];
      tmp[2] = receivedChars[2];
      tmp[3] = '\0';

      degree = strtol(tmp, NULL, 10); // convert array to int


      tmp[0] = receivedChars[3];
      tmp[1] = receivedChars[4];
      tmp[2] = receivedChars[5];
      tmp[3] = '\0';

      distance = strtol(tmp, NULL, 10); // convert array to int

      if (debug) {
        Serial.print("DUINO: Angle (Degrees): ");
        Serial.print(degree);
        Serial.print("  Distance (Pixels): ");
        Serial.println(distance);
      }
      i = 0; // reset static value
      newData = true;
    }
  }
}

/*
   Parses tilt pad inputs from Duino.

   The variable 'roll', device rotation around the front-to-back axis in degrees.
   roll = <int, ranging from -180 to 180 inclusive>

   The variable 'pitch', device rotation around the side-to-side axis in degrees.
   pitch = <int, ranging from -90 to 90 inclusive>
*/
void parseTiltPad() {
  boolean debug = true; // set this to false to hide debug output
  boolean newData = false; // true when newData is ready

  const byte numChars = 9; // number of characters for accepted data
  const char delimeter = '#'; // delimeter that separates unit of data
  char c; // current character

  char receivedChars[numChars];   // an array to store the received data
  static byte i = 0; // current index of array

  int roll; // angle degree
  int pitch; // distance from center


  while (BTSerial.available() > 0 && newData == false) {

    c = BTSerial.read();

    if (c != delimeter) {
      if (isDigit(c) or c == '-') {
        receivedChars[i] = c;
        i++;
        if (i >= numChars) {
          if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
          if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
          while (BTSerial.available() > 0) {
            if ( BTSerial.read() == delimeter) {
              break;
            }
          }
          if (debug) Serial.println("DUINO: <ARDUINO READY>");
          i = 0; // reset static value
          break;
        }
      } else {
        if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
        if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
        while (BTSerial.available() > 0) {
          if ( BTSerial.read() == delimeter) {
            break;
          }
        }
        if (debug) Serial.println("DUINO: <ARDUINO READY>");
        i = 0; // reset static value
        break;
      }
    } else if (i < numChars - 1) {
      if (debug)Serial.println("DUINO: EXCEPTION - INVALID INPUT / DATA MISSED");
      if (debug)Serial.println("DUINO: MSG - WAITING FOR DELIMITER");
      while (BTSerial.available() > 0) {
        if ( BTSerial.read() == delimeter) {
          break;
        }
      }
      if (debug) Serial.println("DUINO: <ARDUINO READY>");
      i = 0; // reset static value
      break;
    }
    else {
      receivedChars[i] = '\0'; // terminate the string (array of characters)

      char tmp[5];

      tmp[0] = receivedChars[0];
      tmp[1] = receivedChars[1];
      tmp[2] = receivedChars[2];
      tmp[3] = receivedChars[3];
      tmp[4] = '\0';

      roll = strtol(tmp, NULL, 10); // convert array to int


      tmp[0] = receivedChars[4];
      tmp[1] = receivedChars[5];
      tmp[2] = receivedChars[6];
      tmp[3] = receivedChars[7];
      tmp[4] = '\0';

      pitch = strtol(tmp, NULL, 10); // convert array to int

      if (debug) {
        Serial.print("DUINO: Roll (Degrees): ");
        Serial.print(roll);
        Serial.print("  Pitch (Degrees): ");
        Serial.println(pitch);
      }
      i = 0; // reset static value
      newData = true;
    }
  }
}


/*
   Send data to Duino.

   Currently unsupported by Duinio.
*/
void writeToBTSerial() {
  /// read from serial and write to the bluetooth module
  if (Serial.available()) {
    BTSerial.write(Serial.read());
  }
}
