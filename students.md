![](assets/images/cover.png)

![](assets/images/gigcity_logo_white.png)
![](assets/images/OCTLogo_RGB.jpg)

\pagebreak


# Workshop 1

## Hello World

One of the first programs you usually write, when learning how to program is 'Hello World'.
'Hello World' is a simple program which prints the text 'Hello World!' somewhere!
Today we're going to get started by printing 'Hello World!' in Minecraft.

XXX: TODO ALL THE THINGS

```python
from mcpi.minecraft import Minecraft
mc = Minecraft.create()

mc.postToChat("Hello World!")
```

You should see the text "Hello World!" appear in your Minecraft chat window.

\pagebreak

# Workshop 2: Magic Door

## Getting started with the Raspberry Pi

Raspberry Pis are tiny but capable little computers, that have similar stuff inside to what you would find in a desktop PC or Mac:

* CPU (you can think of this as the brain of the computer)
* RAM (the computer's memory)
* HDMI Video port (for connecting a monitor)
* USB ports (for connecting a keyboard, mouse and other devices)
* Audio port (for connecting headphones, or speakers)

![](assets/images/Raspberry_Pi_B+_rev_1.2.png)

A Raspberry Pi is also a bit different from a desktop computer, as it has one very special feature - the *GPIO Port*.

![](assets/images/gpio-pins.jpg)

The GPIO port is the set of 24 pins you see in the picture above. GPIO stands for General-purpose Input Output, and is the way the Raspberry Pi can talk to the outside world, controlling special devices, sensors and other electronic doodads. With GPIO, the raspberry Pi goes from being just a little computer, to the heart and brain of all sorts of amazing inventions. 

![](assets/images/gpio-numbers.png)

XXX: description of PI, explaining GPIO


XXX: Examples of cool inventions using the raspberry Pi.


In this workshop, we'll be creating a Magic Door in Minecraft, using the Pi's GPIO port and some electronics components. This magic door will turn an LED connected to our PI on and off every time the door opens and shuts in Minecraft.

### Components

#### Breadboards
![](assets/images/breadboard-rows.jpg)
A breadboard lets us create circuits without having to solder components together. This is great when you want to experiment and change components around (the fancy name for this is *prototyping*). You can't see them under your breadboard because of the adhesive backing, but each row of 5 wee holes is connected by metal clips.

You might be wondering why it is called a breadboard. In the early days of electronics, hobbiests sometimes made circuits on *actual* breadboards. I bet their parents weren't very impressed!

![](assets/images/real-breadboard.jpg)

#### LEDs (Light Emitting Diodes)
![](assets/images/leds.jpg)

LEDs are electronic components that light up when a current is passed through them.

#### Resistors
![](assets/images/resistors.jpg)

A resister is a component that limits the amount of current passing through a circuit. We're going to use one to prevent our LED from burning out too soon.

#### Male to Female jumper cables
![](assets/images/jumper-cable.png)

Jumper cables allow us to create a circuit from the GPIO pins to our breadboard.

\pagebreak

## Creating a Circuit

We're going to make a simple circuit using our breadboard now.

While we're making our circuit, it's important that the Raspberry Pi is switched *off* to help prevent damage to our electronic components.

1. Shutdown your Raspberry Pi. Click *Menu > Shutdown... > Shutdown*.

![](assets/images/shutdown-pi.png)

2. Wait a moment, and then disconnect the power.

XXX: image disconnect power.

3. Wiring up our test circuit

Our first circuit is going to test that our components are working correctly and we have our circuit wired up the right way. 

![](assets/images/led-test_bb.png)

4. Turn your Pi back on

If your circuit is wired up correctly, the LED should turn on when the Pi starts.

5. Shutdown, and turn your Pi off again.

6. Now we're going to move the first wire from pin 1, to the GPIO controlled pin 7.

This will allow us to turn our circuit on and off with code.

![](assets/images/led-gpio-controlled_bb.png)

## Turning the LED on and off with code

1. Open the python editor IDLE.

![](assets/images/run-idle.png)

2. Select *File > New* to open a new editor window.

![](assets/images/file-new-idle.png)

3. Type the following code:

```python
import RPi.GPIO as GPIO


GPIO.setmode(GPIO.BOARD)
GPIO.setup(7, GPIO.OUT)
GPIO.output(7,True)
```

4. Click *Run > Run Module* in IDLE to run this program. You should see the LED turn on.

To turn the LED off again, you can make a change to your program, and run it again:

Change:
```python
GPIO.output(7,True) 
```

to:
```python
GPIO.output(7,False) 
```

\pagebreak

## Turning the LED on and off in Minecraft

Now we're going to make a slightly more complicated program that can turn our LED on and off in Minecraft!

1. Open Minecraft Pi, and start a new world.

![](assets/images/start-mc.png)

![](assets/images/select-world.png)

2. Create a door. It doesn't matter where it goes really, so just in front of you will do.

![](assets/images/create-door.png)

3. Select *File > New* in IDLE to open a new editor window.

4. Type in the following code:

```python
import time

from mcpi.minecraft import Minecraft
import RPi.GPIO as GPIO


GPIO.setmode(GPIO.BOARD)
GPIO.setup(7, GPIO.OUT)

mc = Minecraft.create()
LED = False

while True:
    events = mc.events.pollBlockHits()
    if len(events) > 0:
        if LED == False:
            GPIO.output(7, True)
            LED = True
        else:
            GPIO.output(7, False)
            LED = False
        mc.events.clearAll()
        time.sleep(1)
```

5. Click *Run > Run Module* in IDLE to run this program.

6. In Minecraft, hit the door you made earlier with a sword and you should see the LED turn on. Hit the door again, and the LED should turn off!

Well done!


\pagebreak

# Additional Resources

## Commented Code

Below are commented versions of the code used in the workshops, to help explain what each line of code does.

### Workshop 2: Magic Door

#### Basic LED program

```python

# Import the GPIO library which will let us program the GPIO pins.
import RPi.GPIO as GPIO


# Use board pin numbering, counting from 1 from the top left pin.
GPIO.setmode(GPIO.BOARD)

# Set our output to GPIO Pin 7
GPIO.setup(7, GPIO.OUT)

# Turn on GPIO Pin 7
GPIO.output(7,True)
```

#### Full Magic Door program

```python
# Import the time library, which will let us pause our program for 1 second.
import time

# Import the Minecraft library, which lets us talk to Minecraft.
from mcpi.minecraft import Minecraft
# Import the GPIO library which will let us program the GPIO pins.
import RPi.GPIO as GPIO


# Use board pin numbering, counting from 1 from the top left pin.
GPIO.setmode(GPIO.BOARD)

# Set our output to GPIO Pin 7
GPIO.setup(7, GPIO.OUT)

# This creates a new connection to our Minecraft world, so we get information about what
# Steve is up to in the Minecraft world!
mc = Minecraft.create()

# We need to store the 'state' of our LED, which can be either
# ON or OFF.
# In code, we can represent ON and OFF with True and False.
# Since the LED is OFF to start with, we'll set this to False.
LED = False

# This is the start of an infinite loop.
# Code that follows 'while True' will continue to run until
# we stop our program.
# In game programming, sometimes this is called a 'main loop,
# or 'game loop'.
while True:
    # Our Minecaft object 'mc' can tell us lots of different things
    # about what is happening in Minecraft.
    # Something happening in Minecraft is called an 'event'.
    # The events we want to know about are
    # doors opening and closing, which Minecraft stores as a BlockHit.
    # mc.events.pollBlockHits() will create a List of events if any have occured.
    events = mc.events.pollBlockHits()
    # 'len' is a function which can tell us how many events are in the list of events.
    # Here we want to check if there have been any events. If there haven't, the program
    # will start over again and check for more events later.
    if len(events) > 0:
        # Here we want to check if our LED is turned OFF or ON.
        # If our LED is turned OFF (False), we want to turn it on by setting
        # GPIO pin 7 to True.
        if LED == False:
            GPIO.output(7, True)
            # Now we need to record that we have turned ON our LED.
            LED = True
        # If our LED is already turned ON (True), we need to turn it OFF.
        else:
            # Send 'False' to GPIO pin 7 to turn it OFF.
            GPIO.output(7, False)
            # Record that we have turned our LED OFF.
            LED = False
        # Clear the list of events, since we have already processed them.
        mc.events.clearAll()
        # Pause our program for 1 second. After 1 second the loop will start
        # from the top again.
        time.sleep(1)
```



XXX: Add additional resources, links to projects etc
