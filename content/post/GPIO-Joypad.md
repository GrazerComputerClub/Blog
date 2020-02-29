+++
showonlyimage = false
draft = false
image = "img/GPIO-Input-Joypad.jpg"
date = "2020-02-16"
title = " GPIO-Eingang zur Joypad Emulation"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "Programmierung"]
keywords = ["GPIO", "joypad", "joystick", "uinput", "gambatte", "gameboy", "python"]
weight = 1
+++


Die Anforderung, dass man mit GPIO-Eingängen eine virtuelle Joypad am System erstellt, ist mit dem Raspberry Pi sehr einfach umzusetzen. Ein paar GPIOs und ein paar Zeilen Python-Code reichen. 
<!--more-->


## Aufgabe

Wenn man mit einem Raspberry Pi alten Konsolen wie Gameboy, NES Emulieren will benötigt man eigentlich ein Joypad oder eine Tastatur. Tasten-Eingaben mit GPIO Eingänge zu erzeugen ist sehr einfach, aber wenn man ein Joypad Emulieren möchte, so geht das nicht ohne einen entsprechendes Programm. Mit Python und uinput kann aber so ein Programm erzeugen. Dann kann man mit 8 Tasten ein virtuelles Joypad erstellen, das kompatibel mit NES bzw. Gameboy Eingaben ist. Dies kann für Game-HATs oder auch Gaming Gehäuse für den Raspberry Pi verwendet werden.

 
## uinput Interface 

uinput ist ein Kernelmodul, mit dem Eingabegeräte aus dem Userspace emuliert werden können. Durch Schreiben auf das Gerät /dev/uinput kann ein Programm ein virtuelles Eingabegerät mit bestimmten Funktionen erstellen. Dieses Eingabegerät kann eine Tastatur, Maus oder Joypad bzw. Joystick sein.  
Der Zugriff erfolgt bei Python über das uinput Interface (import uinput). So ist die Erstellung eines virtuellen Joypad sehr einfach. 

```
sudo apt-get install python3-uinput
```

## GPIO Schaltplan 

Es werden mindestens 8 GPIO-Eingänge benötigt:  

* Rauf
* Runter 
* Links 
* Rechts
* Start 
* Select
* A
* B

![Schaltplan GPIO-Input](../../img/GPIO-Input-Joypad.png) 



## GPIO Joypad

Das Programm führt folgende Schritte aus:  

* Interfaces / Bibliotheken einbinden (GPIO, uinput)
* GPIO-Eingänge konfigurieren
* Joypad Achsen und Tasten anlegen bzw. bekannt geben
* Bei entsprechenden GPIO-Eingang die Achse in X- oder Y-Richtung verschieben
* Bei entsprechenden GPIO-Eingang die Buttons drücken und rücksetzen


```python
""" rpi-gpio-jstk.py by Chris Swan 9 Aug 2012
based on python-uinput/examples/joystick.py by tuomasjjrasanen
https://github.com/tuomasjjrasanen/python-uinput/blob/master/examples/joystick.py
"""


import uinput
import time
import RPi.GPIO as GPIO

BTN_FIRE1=15
BTN_FIRE2=14
BTN_UP=16
BTN_DOWN=21
BTN_LEFT=26
BTN_RIGHT=20
BTN_SELECT=3
BTN_START=19
GPIO.setmode(GPIO.BCM)
# Up, Down, left, right, fire
#GPIO.setwarnings(False)
GPIO.setup(BTN_UP, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_DOWN, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_LEFT, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_RIGHT, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_FIRE1, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_FIRE2, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_SELECT, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(BTN_START, GPIO.IN, pull_up_down=GPIO.PUD_UP)

events = (uinput.BTN_SOUTH, uinput.BTN_EAST, uinput.BTN_START, uinput.BTN_SELECT, uinput.ABS_X + (0, 100, 0, 0), uinput.ABS_Y + (0, 100, 0, 0))


device = uinput.Device(events)

# Bools to keep track of movement
fire1 = False
fire2 = False
start = False
select = False
up = False
down = False
left = False
right = False

# Center joystick
# syn=False to emit an "atomic" (50, 50) event.
device.emit(uinput.ABS_X, 50, syn=False)
device.emit(uinput.ABS_Y, 50)

while True:
  if (not start) and (not GPIO.input(BTN_START)):  # start button pressed
    start = True
    device.emit(uinput.BTN_START, 1)
  if start and GPIO.input(BTN_START):              # start button released
    start = False
    device.emit(uinput.BTN_START, 0) 
  if (not select) and (not GPIO.input(BTN_SELECT)):  # select button pressed
    select = True
    device.emit(uinput.BTN_SELECT, 1)
  if select and GPIO.input(BTN_SELECT):              # select button released
    select = False
    device.emit(uinput.BTN_SELECT, 0) 
  if (not fire1) and (not GPIO.input(BTN_FIRE1)):  # Fire1 button pressed
    fire1 = True
    device.emit(uinput.BTN_SOUTH, 1)
  if fire1 and GPIO.input(BTN_FIRE1):              # Fire1 button released
    fire1 = False
    device.emit(uinput.BTN_SOUTH, 0) 
  if (not fire2) and (not GPIO.input(BTN_FIRE2)):  # Fire2 button pressed
    fire2 = True
    device.emit(uinput.BTN_EAST, 1)
  if fire2 and GPIO.input(BTN_FIRE2):              # Fire2 button released
    fire2 = False
    device.emit(uinput.BTN_EAST, 0)
  if (not up) and (not GPIO.input(BTN_UP)):   # Up button pressed
    up = True
    device.emit(uinput.ABS_Y, 0)          # Zero Y
  if up and GPIO.input(BTN_UP):               # Up button released
    up = False
    device.emit(uinput.ABS_Y, 50)        # Center Y
  if (not down) and (not GPIO.input(BTN_DOWN)): # Down button pressed
    down = True
    device.emit(uinput.ABS_Y, 100)        # Max Y
  if down and GPIO.input(BTN_DOWN):             # Down button released
    down = False
    device.emit(uinput.ABS_Y, 50)        # Center Y
  if (not left) and (not GPIO.input(BTN_LEFT)): # Left button pressed
    left = True
    device.emit(uinput.ABS_X, 0)          # Zero X
  if left and GPIO.input(BTN_LEFT):             # Left button released
    left = False
    device.emit(uinput.ABS_X, 50)        # Center X
  if (not right) and (not GPIO.input(BTN_RIGHT)):# Right button pressed
    right = True
    device.emit(uinput.ABS_X, 100)        # Max X
  if right and GPIO.input(BTN_RIGHT):            # Right button released
    right = False
    device.emit(uinput.ABS_X, 50)        # Center X
  time.sleep(.02)  # Poll every 20ms (otherwise CPU load gets too high)
```


```
sudo python3 joypad.py &
```

Wenn der Fehler "OSError: [Errno 19] Failed to open the uinput device: No such device" ausgegeben wird, so ist das uinput Device nicht verfügbar. Dann kann mit "sudo modprobe uinput" das Kernel-Modul geladen werden.  

Testen kann man die Funktion mit dem Joystick Testprogramm "jstest".

```
sudo apt-get install joystick
jstest /dev/input/js0
```

```
Driver version is 2.1.0.
Joystick (python-uinput) has 2 axes (X, Y)
and 4 buttons (BtnA, BtnB, BtnSelect, BtnStart).
Testing ... (interrupt to exit)
Axes:  0:     0  1:     0 Buttons:  0:off  1:off  2:off  3:off 
```

## Testen mit Gameboy Emulation


Nun kann man das Joypad im Einsatz mit einer Gameboy Color Emulation testen. 
Zuerst muss der Emulator Gambatte aber noch kompiliert und installiert werden, da er nicht im Raspbian vorhanden ist. Bei Raspjamming Image ist er bereits vorinstalliert. 

```
git clone https://github.com/sinamas/gambatte
cd gambatte
sudo apt-get install scons libsdl1.2-dev zlib1g-dev
sed -i "2 i\global_cflags = global_cflags + \' -mcpu=arm1176jzf-s -mfloat-abi=hard -mfpu=vfp\'" libgambatte/SConstruct
sed -i "4 i\cflags = cflags + \' -mcpu=arm1176jzf-s -mfloat-abi=hard -mfpu=vfp\'" gambatte_sdl/SConstruct
./build_sdl.sh
sudo mv gambatte_sdl/gambatte_sdl /usr/local/bin/gambatte
```

Benötigte Laufzeit Bibliotheken:  
sudo apt-get install libsdl1.2debian zlib1g


Nun wird noch ein Freeware Gameboy Color Spiel wie z.B. Skoardy benötigt.

```
wget http://www.skoardy.com/skoardygb.zip
unzip skoardygb.zip Skoardy.gb
rm skoardygb.zip
```

Die Joypad Tasten müssen beim Gambatte Emulator als Parameter übergeben werden. Dabei gilt:

jsNaM+ ... Joystick N axis M +  
jsNaM- ... Joystick N axis M -  
jsNbM	 ... Joystick N button M  

-i, --input KEYS		Use the 8 given input KEYS for respectively  
				    START SELECT A B UP DOWN LEFT RIGHT

Die Auflösung von 160×144 Pixel kann mit Parameter s auf 320x288 verdoppelt werden, wenn mindestens 640x480 zur Verfügung stehen.

-s, --scale N			Scale video output by an integer factor of N

Nun kann Gambatte mit allen Parametern gestartet werden.

```
gambatte -s 2 -y -i js0b3 js0b2 js0b0 js0b1 js0a1- js0a1+ js0a0- js0a0+ Skoardy.gb &
```

## Youtube Video

[![GPIO Maus Video](http://img.youtube.com/vi/6zO5fgMRnh0/0.jpg)](https://www.youtube.com/watch?v=6zO5fgMRnh0)

