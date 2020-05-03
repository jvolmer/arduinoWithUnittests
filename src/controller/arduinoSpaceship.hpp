#ifndef ARDUINO_SPACESHIP_H
#define ARDUINO_SPACESHIP_H

#include "model/hyperdrive.hpp"
#include "model/laser.hpp"
#include "model/button.hpp"
#include "controller/spaceship.hpp"

class ArduinoSpaceship: public Spaceship
{
public:
    ArduinoSpaceship(Button* button, Hyperdrive* hyperdrive, Laser* laser);
    void print();
};

#endif
