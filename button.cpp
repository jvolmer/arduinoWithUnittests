#include "Arduino.h"
#include "button.hpp"

ArduinoButton::ArduinoButton(const int pin):
    pin { pin }
{
}

ArduinoButton::ArduinoButton():
    pin { 0 }
{
}

void ArduinoButton::setup()
{
    pinMode(pin, INPUT);
}

void ArduinoButton::read()
{
    state = digitalRead(pin);
}

bool ArduinoButton::isPressed()
{
    return state;
}
