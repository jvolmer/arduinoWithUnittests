# arduino installation location
ARDUINO_DIR = $(HOME)/bin/arduino-1.8.10/

# arduino programs
AVR_CC = $(ARDUINO_DIR)hardware/tools/avr/bin/avr-gcc
AVR_CXX = $(ARDUINO_DIR)hardware/tools/avr/bin/avr-g++
AVR_AR = $(ARDUINO_DIR)hardware/tools/avr/bin/avr-ar
AVR_OBJCOPY = $(ARDUINO_DIR)hardware/tools/avr/bin/avr-objcopy
AVR_DUDE = $(ARDUINO_DIR)hardware/tools/avr/bin/avrdude

# arduino specifications
F_CPU = 16000000
MCU = atmega328p

# compiler flags

GENERAL_FLAGS = -MT $@ -MMD -MP -MF $(@:%.o=%.d) -std=gnu++14 -Wall

AVRCOMPILE_FLAGS = -x c++ -ffunction-sections -fdata-sections -mmcu=$(MCU) -DF_CPU=$(F_CPU)L -Os -include Arduino.h $(GENERAL_FLAGS)
AVRLINK_FLAGS = -mmcu=$(MCU) -Wl,--gc-sections -Os 
AVR_INC = -I $(ARDUINO_DIR)hardware/arduino/avr/cores/arduino/ -I $(ARDUINO_DIR)hardware/arduino/avr/variants/standard
AVRDUDE_CONF = $(ARDUINO_DIR)hardware/tools/avr/etc/avrdude.conf
ARDUINO_LIB = $(HOME)/lib/arduino/coreObjectFiles/libcore.a

CXX = g++
CXX_FLAGS = -Wall -Wno-deprecated-declarations $(GENERAL_FLAGS)
LDFLAGS  = -lboost_unit_test_framework -lm
CXX_INC = -I $(HOME)/bin/turtle_1.3.1/include

# files

MAIN_SOURCES = main_spaceship.cpp
CLASS_SOURCES = spaceship.cpp hyperdrive.cpp laser.cpp button.cpp

TESTS = spaceship.test
TEST_SOURCES = test_spaceship.cpp


# upload to arduino

upload_% : %.hex
	$(AVR_DUDE) -C$(AVRDUDE_CONF) -v -p$(MCU) -carduino -P/dev/ttyACM0 -b115200 -D -Uflash:w:$<:i

# arduino compilation

%.hex : %.elf
	$(AVR_OBJCOPY) -O ihex -R .eeprom $< $@

%.elf : %.avr_o $(CLASS_SOURCES:.cpp=.avr_o)
	$(AVR_CC) $(AVRLINK_FLAGS) -o $@ $^ $(ARDUINO_LIB) -lc -lm

%.avr_o : %.cpp
	$(AVR_CXX) $(AVR_INC) $(AVRCOMPILE_FLAGS) $< -c -o $@

# test compilation

tests : $(TESTS)

%.test : test_%.o %.o
	$(CXX) $(CXX_FLAGS) $^ -o $@ $(LDFLAGS)
	@echo Running $@
	@./$@ #--log_level=test_suite
	@echo 

test_%.o : test_%.cpp
	$(CXX) $(CXX_FLAGS) $< -c -o $@ $(CXX_INC)

# Makefile stuff

clean : 
	rm -f *.o *.avr_o *.d *.elf *.hex *.test

# use .d (dependency) files for prerequisite generation
DEPFILES := $(MAIN_SOURCES:.cpp=.d) $(CLASS_SOURCES:.cpp=.d) $(TEST_SOURCES:.cpp=.d)
$(DEPFILES):
include $(wildcard $(DEPFILES))

# targets that are not files
.PHONY : upload clean tests
# targets that are not explicitly named in Makefile should not automatically be deleted
.SECONDARY : $(MAIN_SOURCES:.cpp=.avr_o) $(MAIN_SOURCES:.cpp=.elf) $(MAIN_SOURCES:.cpp=.hex) $(CLASS_SOURCES:.cpp=.avr_o) $(TEST_SOURCES:.cpp=.avr_o)
