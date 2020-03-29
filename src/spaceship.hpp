#ifndef SPACESHIP_H
#define SPACESHIP_H

#include "hyperdrive.hpp"
#include "laser.hpp"
#include "button.hpp"

class Spaceship
{
private:
    Button* button;
    Hyperdrive* hyperdrive;
    Laser* laser;
public:
    Spaceship(Button* button, Hyperdrive* hyperdrive, Laser* laser);
    void setup();
    void loop();
};

#endif
