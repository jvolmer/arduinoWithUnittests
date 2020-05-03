#ifndef SPACESHIP_H
#define SPACESHIP_H

#include "../model/hyperdrive.hpp"
#include "../model/laser.hpp"
#include "../model/button.hpp"

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
