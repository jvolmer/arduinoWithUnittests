#include "Arduino.h"
#include "laser.hpp"

ArduinoLaser::ArduinoLaser(const int pin1, const int pin2):
    pin1 { pin1 },
    pin2 { pin2 }
{
}

void ArduinoLaser::setup()
{
    pinMode(pin1, OUTPUT);
    pinMode(pin2, OUTPUT);
}

void ArduinoLaser::fire()
{
    digitalWrite(pin1, LOW);
    digitalWrite(pin2, HIGH);
    delay(250);
    digitalWrite(pin1, HIGH);
    digitalWrite(pin2, LOW);
    delay(250);
}

void ArduinoLaser::stop()
{
    digitalWrite(pin1, LOW);
    digitalWrite(pin2, LOW);
}
