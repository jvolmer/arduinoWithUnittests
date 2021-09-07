set(LIBRARY ${CMAKE_PROJECT_NAME}_lib)
set(TARGET ${CMAKE_PROJECT_NAME}_main)

add_library(${LIBRARY} STATIC "")
target_compile_options(${LIBRARY} PRIVATE $<$<CONFIG:Debug>:--coverage>)
target_link_options(${LIBRARY} INTERFACE $<$<CONFIG:Debug>:--coverage>)

if (CMAKE_CXX_COMPILER MATCHES avr)

  find_program(AVR_OBJCOPY avr-objcopy)
  
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
    BYPRODUCTS ${CMAKE_PROJECT_NAME}.hex
    DEPENDS ${TARGET})
  
  add_custom_target(upload
    COMMAND ${AVRDUDE} -v -C ${ARVDUDE_CONF} -p ${MCU} -c ${UPLOAD_PROTOCOL} -P ${PORT} -b ${UPLOAD_SPEED} -D -U flash:w:${CMAKE_PROJECT_NAME}.hex:i
    DEPENDS hex)
  
  add_subdirectory(model)
  
endif()

add_subdirectory(controller)
