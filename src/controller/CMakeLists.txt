target_sources(${LIBRARY} PRIVATE spaceship.cpp spaceship.hpp)

if (CMAKE_CXX_COMPILER MATCHES avr)

  target_sources(${TARGET} PRIVATE arduinoSpaceship.cpp arduinoSpaceship.hpp)
  
endif()
