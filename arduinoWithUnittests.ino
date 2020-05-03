#include "src/controller/arduinoSpaceship.hpp"
#include "src/model/hyperdrive.hpp"
#include "src/model/laser.hpp"
#include "src/model/button.hpp"

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
