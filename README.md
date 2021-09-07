# Arduino with Unittests [![Build](https://github.com/jvolmer/arduinoWithUnittests/actions/workflows/test.yml/badge.svg)](https://github.com/jvolmer/arduinoWithUnittests/actions/workflows/test.yml) [![Code Coverage](https://codecov.io/gh/jvolmer/arduinoWithUnittests/branch/main/graph/badge.svg)](https://codecov.io/gh/jvolmer/arduinoWithUnittests)

This example program demonstrates a way to write and run unit tests for code written for the Aruduino. It uses the [Arduino Spaceship Interface Example](https://programminginarduino.wordpress.com/2016/02/29/project-2/) for this demonstration. It is based on the idea of testing all higher level classes that do not have any Arduino implementation. The Makefile defines the compilation of the tests and the arduino code, as well as the upload to the arduino board - such that the Arduino IDE is not needed at all.

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


## Usage
The executable only compiles with the avr-g++ compiler, you have to set this explicitely when configuring the project
```bash
cmake -S . -B build/ -D CMAKE_CXX_COMPILER=avr-g++
```
Then you can build the executable with
```bash
cmake --build build/
```

Upload the program to the Arduino via
```bash
cmake --build build/ --target upload
```

### Tests
They only work when the build was configured with a standard C++ compiler, so if you already configured the project with the avr-g++ compiler, you have to reconfigure the project to be able to run the tests, e.g. with the g++ compiler:
```bash
cmake -S . -B build -D CMAKE_CXX_COMPILER=g++
```
Then you can run the tests via
```bash
cmake --build build/ --target test
```

You can get test coverage information in Debug configuration:
```bash
cmake -S . -B build -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=g++
cmake --build build/ --target test
```
This gives an overview on the command line and writes all information into file coverage.xml.


## Install
These are the prerequisites you need to install in order to build the program:
* [Arduino-IDE](https://www.arduino.cc/en/software)
* [Conan.io](https://docs.conan.io/en/latest/installation.html)
* [cmake 3.13+](https://cmake.org/download/)
* avr-g++ and avr-objcopy (an old but still relevant installation description for the full avr toolchain can be found [here](https://mightyohm.com/blog/tutorials/avr-toolchain-installation/))
* C++ compiler, e.g. GNU C++ Compiler g++

You also need the Arduino core library, which you can create by yourself with the Arduino source you files and cmake, I will shortly create a description on how to do that.

Additionally, you have to set the variables in variables.cmake according to you computer, microcontroller and Arduino IDE installation specifics.

Inside the project directory, install the dependencies:
```bash
conan install -if build .
```

Configure the build system:
```bash
cmake -S . -B build
```
This project includes tests that only compile with a standard C++ compiler (e.g. g++) and the executable that only compiles with the avr-g++ compiler, therefore depending what you want to do, you have to set the following variables when configuring the build system, add the following to the line above:
* for executable to compile use `-D CMAKE_CXX_COMPILER=avr-g++`
* for test to compile add `-D CMAKE_CXX_COMPILER=g++`
* for measuring coverage use `-D CMAKE_CXX_COMPILE=g++ -D CMAKE_BUILD_TYPE=Debug`
Have a look at the Usage section for a more detailed explanation how and when to use these variables.
