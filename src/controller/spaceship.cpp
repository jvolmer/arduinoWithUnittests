#include "model/button.hpp"
#include "model/hyperdrive.hpp"
#include "model/laser.hpp"
#include "spaceship.hpp"

Spaceship::Spaceship(Button* button, Hyperdrive* hyperdrive, Laser* laser) :
    button { button },
    hyperdrive { hyperdrive },
    laser { laser }
{
}

void Spaceship::setup()
{
    hyperdrive->setup();
    laser->setup();
    button->setup();
}

void Spaceship::loop()
{
    button->read();
    
    if (button->isPressed())
    {
        hyperdrive->deactivate();
        laser->fire();
    }
    else
    {
        laser->stop();
        hyperdrive->activate();
    }
}
