+++
title = "First-time fun with an Arduino"
date = "Mon, 16 Sep 2013 22:01:55 +0000"
draft = false
tags = ["Arduino", "C++", "Electronics"]
aliases = ["/2013/09/first-time-fun-with-an-arduino/"]
+++

So the other day I got an early birthday present courtesy of my lovely girlfriend, an [Arduino Mega2560](http://arduino.cc/en/Main/ArduinoBoardMega2560) purchased from CPC.

I've only had a few hours to play around with it so far, but I have a basic circuit and Sketch (which is Arduino parlance for the C program that is to be uploaded to the ATmega chip), as you can see...

{{< thumbnail x300 "arduino.jpg" "Arduino pulsing an LED" >}}

It is really basic at the moment, the program listens for input from the button and every time you press it either pauses or unpauses the [PWM (Pulse Width Modulation)](http://en.wikipedia.org/wiki/Pulse-width_modulation) in-and-out fading of the LED.

The button is wired to a 10k pull-down resistor. The Arduino actually has the ability to do this itself, you get to choose whether you pull-down yourself or leave it up to the Arduino - Actually I wonder if it is the Atmega chip doing the pulldown, rather than the Arduino.

Every time you toggle the pause/unpause it sends a serial communication through the USB back for display on the Serial monitor (provided as part of the Arduino IDE). It's really easy to do, but quite a powerful feature built-in.

I need to think up some interesting projects to do with it - Maybe some kind of robot? A robot arm? I have a RaspberryPi, maybe I can achieve something interesting if I wire them together?