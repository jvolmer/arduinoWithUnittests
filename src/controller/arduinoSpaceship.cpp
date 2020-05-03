#include "model/button.hpp"
#include "model/hyperdrive.hpp"
#include "model/laser.hpp"
#include "arduinoSpaceship.hpp"

ArduinoSpaceship::ArduinoSpaceship(Button* button, Hyperdrive* hyperdrive, Laser* laser) :
    Spaceship {button, hyperdrive, laser}
{}

void ArduinoSpaceship::print()
{
    Serial.println("test");
}
