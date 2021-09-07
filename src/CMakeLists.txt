set(LIBRARY ${CMAKE_PROJECT_NAME}_lib)
set(TARGET ${CMAKE_PROJECT_NAME}_main)
set(ARDUINO_CORE ArduinoCore)

add_library(${LIBRARY} STATIC "")
target_compile_options(${LIBRARY} PRIVATE $<$<CONFIG:Debug>:--coverage>)
target_link_options(${LIBRARY} INTERFACE $<$<CONFIG:Debug>:--coverage>)

if (CMAKE_CXX_COMPILER MATCHES avr)

  find_program(AVR_OBJCOPY avr-objcopy)
  find_program(AVR_GCC avr-gcc)
  find_program(AVR_AR avr-ar)
  set(CMAKE_C_COMPILER ${AVR_GCC})
  set(CMAKE_AR ${AVR_AR})
  
  add_library(${ARDUINO_CORE} STATIC ${ARDUINO_CORE_SRCS})
  
  add_executable(${TARGET} main.cpp)
  add_dependencies(${TARGET} ${ARDUINO_CORE})
  target_link_libraries(${TARGET} ${LIBRARY} ${PROJECT_BINARY_DIR}/src/lib${ARDUINO_CORE}.a)

  set_property(TARGET ${ARDUINO_CORE} ${TARGET}
    PROPERTY
    INCLUDE_DIRECTORIES ${ARDUINO_INCLUDES})
  set_property(TARGET ${ARDUINO_CORE} ${TARGET}
    PROPERTY
    COMPILE_OPTIONS
    -ffunction-sections -fdata-sections
    -mmcu=${MCU} -DF_CPU=${F_CPU}L
    -Os)
  set_property(TARGET ${ARDUINO_CORE} ${TARGET}
    PROPERTY
    LINK_OPTIONS
    -mmcu=${MCU}
    LINKER:--gc-sections
    -Os)
  
  add_custom_target(hex
    COMMAND ${AVR_OBJCOPY} -R .eeprom -O ihex ${TARGET} ${CMAKE_PROJECT_NAME}.hex
    BYPRODUCTS ${CMAKE_PROJECT_NAME}.hex
    DEPENDS ${TARGET})
  
  add_custom_target(upload
    COMMAND ${AVRDUDE} -v -C ${ARVDUDE_CONF} -p ${MCU} -c ${UPLOAD_PROTOCOL} -P ${PORT} -b ${UPLOAD_SPEED} -D -U flash:w:${CMAKE_PROJECT_NAME}.hex:i
    DEPENDS hex)
  
  add_subdirectory(model)
  
endif()

add_subdirectory(controller)
