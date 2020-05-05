# Arduino with Unittests

This example program defines classes for the [Arduino Spaceship Interface Example](https://programminginarduino.wordpress.com/2016/02/29/project-2/) and uses unit tests to test the higher level classes that do not have any Arduino implementation. The Makefile defines the compilation of the tests and the arduino code, as well as the upload to the arduino board - without any need for the Arduino IDE.

## Class structure:
```
          --------------- Spaceship ----------------
         |                    |                     |
         |                    |                     |
         |                    |                     |
         |                    |                     |
         v                    v                     v
   <<Interface>>        <<Interface>>         <<Interface>>
       Button               Laser               Hyperdrive
       	 Δ                    Δ       	            Δ
	 
         |                    |                     |

         |                    |                     |

   ArduinoButton        ArduinoLaser        ArduinoHyperdrive
```

## Some explanation:
The code includes unittests for the high-level class Spaceship by mocking Button, Laser and Hyperdrive. This is possible because only the implementation classes ArduinoButton, ArduinoLaser and ArduinoHyperdrive include Arduino-specific code. The Interfaces Button, Laser and Hyperdrive are needed here to be able to test the Spaceship class without any Arduino-specific code.

## Prerequisites:
- Arduino-IDE

or

- Arduino-Tools (installing the Arduino-IDE will install all of this)
- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- g++ Compiler (for at least c++14)
- Precompiled Arduino Core Library (can be done by yourself using the Arduino-Tools, I will upload a Makefile in a short while)

For unit tests:
- [Boost.Test](https://www.boost.org/doc/libs/1_66_0/libs/test/doc/html/index.html)
- [Turtle](http://turtle.sourceforge.net)

## Usage:
Run Tests:
```bash
make tests
```

Compile the program with entry point arduinoWithUnittests.ino to bin/arduinoWithUnittests.hex:
```bash
make main_spaceship.elf
```

(Compile and) Upload the program to Arduino:
```bash
make upload
```

