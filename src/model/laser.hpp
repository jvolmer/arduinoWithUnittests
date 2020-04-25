#ifndef LASER_H
#define LASER_H

class Laser
{
public:
    virtual void setup() = 0;
    virtual void fire() = 0;
    virtual void stop() = 0;
};
   
class ArduinoLaser : public Laser
{
private:
    const int pin1;
    const int pin2;
public:
    ArduinoLaser(const int pin1, const int pin2);
    void setup() override;
    void fire() override;
    void stop() override;
};
    
#endif
