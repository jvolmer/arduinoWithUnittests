#include "controller/arduinoSpaceship.hpp"
#include "model/hyperdrive.hpp"
#include "model/laser.hpp"
#include "model/button.hpp"
#include "Arduino.h"

ArduinoHyperdrive hyperdrive(3);
ArduinoLaser laser(4,5);
ArduinoButton button(2);
ArduinoSpaceship spaceship(&button, &hyperdrive, &laser);

void setup() {
    spaceship.setup();
    spaceship.print();
}

void loop() {
    spaceship.loop();
}
