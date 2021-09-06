# Definitions =====================================

if (CMAKE_CXX_COMPILER MATCHES avr)
  
  # computer specific
  set(PORT /dev/ttyACM0)
  # microcontroller specific
  set(F_CPU 16000000)
  set(MCU atmega328p)
  set(UPLOAD_PROTOCOL arduino)
  set(UPLOAD_SPEED 115200)

  # arduino specific
  set(ARDUINO_LIB /home/jvolmer/lib/arduino/coreObjectFiles/libcore.a)
  set(ARDUINO_DIR /home/jvolmer/bin/arduino-1.8.10)
  set(ARDUINO_INCLUDES
    ${ARDUINO_DIR}/hardware/arduino/avr/cores/arduino/;
    ${ARDUINO_DIR}/hardware/arduino/avr/variants/standard/)
  set(AVRDUDE ${ARDUINO_DIR}/hardware/tools/avr/bin/avrdude)
  set(ARVDUDE_CONF ${ARDUINO_DIR}/hardware/tools/avr/etc/avrdude.conf)
  
endif()

# ===================================================


set(LIBRARY ${CMAKE_PROJECT_NAME}_lib)
set(TARGET ${CMAKE_PROJECT_NAME}_main)

find_program(GCOV_PATH gcov)
add_library(${LIBRARY} STATIC "")
target_compile_options(${LIBRARY} PRIVATE $<$<CONFIG:Debug>:--coverage>)
target_link_libraries(${LIBRARY} PRIVATE $<$<CONFIG:Debug>:gcov>)

if (CMAKE_CXX_COMPILER MATCHES avr)

  find_program(AVR_OBJCOPY avr-objcopy)
  find_program(AVR-G++ avr-g++)
  
  add_executable(${TARGET} main.cpp)
  target_link_libraries(${TARGET} PRIVATE ${LIBRARY} ${ARDUINO_LIB})
  target_include_directories(${TARGET} PRIVATE ${ARDUINO_INCLUDES})
  target_compile_options(${TARGET} PRIVATE
    -ffunction-sections -fdata-sections
    -mmcu=${MCU} -DF_CPU=${F_CPU}L
    -Os)
  target_link_options(${TARGET} PRIVATE
    -mmcu=${MCU}
    -Wl,--gc-sections
    -Os)
  
  add_custom_target(hex
    COMMAND ${AVR_OBJCOPY} -R .eeprom -O ihex ${TARGET} ${CMAKE_PROJECT_NAME}.hex
    DEPENDS ${TARGET})
  
  add_custom_target(upload
    COMMAND ${AVRDUDE} -v -C ${ARVDUDE_CONF} -p ${MCU} -c ${UPLOAD_PROTOCOL} -P ${PORT} -b ${UPLOAD_SPEED} -D -U flash:w:${CMAKE_PROJECT_NAME}.hex:i
    DEPENDS hex)
  
  add_subdirectory(model)
  
endif()

add_subdirectory(controller)
