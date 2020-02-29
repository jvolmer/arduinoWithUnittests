#include "spaceship.hpp"
#include "hyperdrive.hpp"
#include "laser.hpp"
#include "button.hpp"

ArduinoHyperdrive hyperdrive(3);
ArduinoLaser laser(4,5);
ArduinoButton button(2);
Spaceship spaceship(&button, &hyperdrive, &laser);

void setup() {
    spaceship.setup();
}

void loop() {
    spaceship.loop();
}
