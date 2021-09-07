if (CMAKE_CXX_COMPILER MATCHES avr)
  
  # computer specific
  set(PORT /dev/ttyACM0)
  
  # microcontroller specific
  set(F_CPU 16000000)
  set(MCU atmega328p)
  set(UPLOAD_PROTOCOL arduino)
  set(UPLOAD_SPEED 115200)

  # depending on your Arduino IDE installation
  set(ARDUINO_DIR /home/jvolmer/bin/arduino-1.8.10)
  set(ARDUINO_INCLUDES
    ${ARDUINO_DIR}/hardware/arduino/avr/cores/arduino/;
    ${ARDUINO_DIR}/hardware/arduino/avr/variants/standard/)
  # avrdude version must be at least from 2019, is given for version from Arduino IDE
  set(AVRDUDE ${ARDUINO_DIR}/hardware/tools/avr/bin/avrdude)
  set(ARVDUDE_CONF ${ARDUINO_DIR}/hardware/tools/avr/etc/avrdude.conf)

  # self-compiled library from the Arduino source files
  set(ARDUINO_LIB /home/jvolmer/lib/arduino/coreObjectFiles/libcore.a)

endif()
