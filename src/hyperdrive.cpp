#include "Arduino.h"
#include "hyperdrive.hpp"

ArduinoHyperdrive::ArduinoHyperdrive(const int pin):
    pin { pin }
{
}

void ArduinoHyperdrive::setup()
{
    pinMode(pin, OUTPUT);
}

void ArduinoHyperdrive::activate()
{
    digitalWrite(pin, HIGH);
}

void ArduinoHyperdrive::deactivate()
{
    digitalWrite(pin, LOW);
}
