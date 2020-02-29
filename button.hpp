#ifndef BUTTON_H
#define BUTTON_H

class Button
{
public:
    virtual void setup() = 0;
    virtual void read() = 0;
    virtual bool isPressed() = 0;
};

class ArduinoButton : public Button
{
private:
    const int pin;
    int state;
    
public:
    ArduinoButton();
    ArduinoButton(const int pin);
    void setup() override;
    void read() override;
    bool isPressed() override;
};

#endif
