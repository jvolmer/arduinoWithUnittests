#ifndef HYPERDRIVE_H
#define HYPERDRIVE_H

class Hyperdrive
{
public:
    virtual void setup() = 0;
    virtual void activate() = 0;
    virtual void deactivate() = 0;
};

class ArduinoHyperdrive : public Hyperdrive
{
private:
    const int pin;
public:
    ArduinoHyperdrive(const int pin);
    void setup() override;
    void activate() override;
    void deactivate() override;
};

#endif
