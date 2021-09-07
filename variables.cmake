if (CMAKE_CXX_COMPILER MATCHES avr)
  
  # computer specific
  set(PORT /dev/ttyACM0)
  
  # microcontroller specific
  set(F_CPU 16000000)
  set(MCU atmega328p)
  set(UPLOAD_PROTOCOL arduino)
  set(UPLOAD_SPEED 115200)

  # depending on your Arduino IDE installation
  set(ARDUINO_DIR "") # set this to the installation path of the Arduino IDE
  set(ARDUINO_CORE_DIR ${ARDUINO_DIR}/hardware/arduino/avr/cores/arduino)
  list(APPEND ARDUINO_CORE_SRCS
    ${ARDUINO_CORE_DIR}/abi.cpp
    ${ARDUINO_CORE_DIR}/Arduino.h
    ${ARDUINO_CORE_DIR}/binary.h
    ${ARDUINO_CORE_DIR}/CDC.cpp
    ${ARDUINO_CORE_DIR}/Client.h
    ${ARDUINO_CORE_DIR}/HardwareSerial0.cpp
    ${ARDUINO_CORE_DIR}/HardwareSerial1.cpp
    ${ARDUINO_CORE_DIR}/HardwareSerial2.cpp
    ${ARDUINO_CORE_DIR}/HardwareSerial3.cpp
    ${ARDUINO_CORE_DIR}/HardwareSerial.cpp
    ${ARDUINO_CORE_DIR}/HardwareSerial.h
    ${ARDUINO_CORE_DIR}/HardwareSerial_private.h
    ${ARDUINO_CORE_DIR}/hooks.c
    ${ARDUINO_CORE_DIR}/IPAddress.cpp
    ${ARDUINO_CORE_DIR}/IPAddress.h
    ${ARDUINO_CORE_DIR}/main.cpp
    ${ARDUINO_CORE_DIR}/new.cpp
    ${ARDUINO_CORE_DIR}/new.h
    ${ARDUINO_CORE_DIR}/PluggableUSB.cpp
    ${ARDUINO_CORE_DIR}/PluggableUSB.h
    ${ARDUINO_CORE_DIR}/Printable.h
    ${ARDUINO_CORE_DIR}/Print.cpp
    ${ARDUINO_CORE_DIR}/Print.h
    ${ARDUINO_CORE_DIR}/Server.h
    ${ARDUINO_CORE_DIR}/Stream.cpp
    ${ARDUINO_CORE_DIR}/Stream.h
    ${ARDUINO_CORE_DIR}/Tone.cpp
    ${ARDUINO_CORE_DIR}/Udp.h
    ${ARDUINO_CORE_DIR}/USBAPI.h
    ${ARDUINO_CORE_DIR}/USBCore.cpp
    ${ARDUINO_CORE_DIR}/USBCore.h
    ${ARDUINO_CORE_DIR}/USBDesc.h
    ${ARDUINO_CORE_DIR}/WCharacter.h
    ${ARDUINO_CORE_DIR}/WInterrupts.c
    ${ARDUINO_CORE_DIR}/wiring_analog.c
    ${ARDUINO_CORE_DIR}/wiring.c
    ${ARDUINO_CORE_DIR}/wiring_digital.c
    ${ARDUINO_CORE_DIR}/wiring_private.h
    ${ARDUINO_CORE_DIR}/wiring_pulse.c
    ${ARDUINO_CORE_DIR}/wiring_shift.c
    ${ARDUINO_CORE_DIR}/WMath.cpp
    ${ARDUINO_CORE_DIR}/WString.cpp
    ${ARDUINO_CORE_DIR}/WString.h)
  set(ARDUINO_INCLUDES
    ${ARDUINO_CORE_DIR}/;
    ${ARDUINO_DIR}/hardware/arduino/avr/variants/standard/)
  # avrdude version must be at least from 2019, is given for version from Arduino IDE
  set(AVRDUDE ${ARDUINO_DIR}/hardware/tools/avr/bin/avrdude)
  set(ARVDUDE_CONF ${ARDUINO_DIR}/hardware/tools/avr/etc/avrdude.conf)
  
endif()
