+++
showonlyimage = false
draft = false
image = "img/WiringPi.png"
date = "2022-01-12"
title = "WiringPi Library"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["WiringPi", "GPIO"]
weight = 1
+++

WiringPi ist einer C-Library für den Zugriff auf GPIOs des Raspberry Pi. Leider wurde es aus dem Raspberry Pi OS entfernt. zum Glück wird sie aber noch gewartet und kann manuell installiert werden.
<!--more-->

## Beschreibung 

WiringPi ist eine C-Bibliothek für den Zugriff auf Funktionen der GPIOs des Raspberry Pi Computers. Sie wird unter der GNU LGPLv3 Lizenz angeboten. Ursprünglich wurde sie von Gordon Drogon entwickelt. Er hat sich allerdings inzwischen vom Projekt zurückgezogen. Dadurch würde es leider auch aus dem neuesten Raspberry Pi OS (Bullseye) entfernt. Früher konnte man zumindest eine ältere Version mit ``apt install wiringpi`` installieren, aber das geht nun nicht mehr.  
Das ist sehr unverständlich den WiringPi wird nach wie vor weiter gewartet und für die neueren Raspberry Pi Produkte wie z. B. Pi 400 und Zero 2 angepasst. Der frei Verfügbare Sourcecode steht liegt bei Git-Hub unter https://github.com/WiringPi/WiringPi.
Leider gebt es keine fertiges apt-Repository oder auch eine DEB-Datei. Aus diesem Grund muss man das Projekt selbst übersetzen bzw. eine DEB-Datei für die Installation erzeugen.


## Installation

```
git clone https://github.com/WiringPi/WiringPi.git
cd WiringPi
./build 
./build debian
mv debian-template/wiringpi-2.61-1.deb .
sudo apt install ./wiringpi-2.61-1.deb
```

## Verwendung


WiringPi enthält nicht nur die C-Bibliothek, auch das Kommandozeilenprogramm ``gpio`` wird mit ausgeliefert. Es kann genutzt werden, um von der Konsole oder einem Shell-Skript aus auf die GPIOs zugreifen zu können. Standardmäßig wird eine eigene WiringPi-Nummerierung für die Pins verwendet. Wenn man allerdings den Parameter  ``-g`` hinzufügt, werden die BCM-Nummern verwendet. Früher musste das Programm mit root-Rechten bzw. über sudo gestartet werden. Dies ist inzwischen nicht mehr nötig. Mit dem Befehl ``gpio readall`` kann der aktuelle Status der GPIOs ausgegeben werden.

**Pi400:**
```
gpio -v
```
```
gpio version: 2.61
Copyright (c) 2012-2018 Gordon Henderson
This is free software with ABSOLUTELY NO WARRANTY.
For details type: gpio -warranty

Raspberry Pi Details:
  Type: Pi 400, Revision: 00, Memory: 4096MB, Maker: Sony 
  * Device tree is enabled.
  *--> Raspberry Pi 400 Rev 1.0
  * This Raspberry Pi supports user-level GPIO access.
```

```
gpio readall
```
```
+-----+-----+---------+------+---+---Pi 400-+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   2 |   8 |   SDA.1 |   IN | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   3 |   9 |   SCL.1 |   IN | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | IN   | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | IN   | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  27 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
 |   0 |  30 |   SDA.0 |   IN | 1 | 27 || 28 | 1 | IN   | SCL.0   | 31  | 1   |
 |   5 |  21 | GPIO.21 |   IN | 1 | 29 || 30 |   |      | 0v      |     |     |
 |   6 |  22 | GPIO.22 |   IN | 1 | 31 || 32 | 0 | IN   | GPIO.26 | 26  | 12  |
 |  13 |  23 | GPIO.23 |   IN | 0 | 33 || 34 |   |      | 0v      |     |     |
 |  19 |  24 | GPIO.24 |   IN | 0 | 35 || 36 | 0 | IN   | GPIO.27 | 27  | 16  |
 |  26 |  25 | GPIO.25 |   IN | 0 | 37 || 38 | 0 | IN   | GPIO.28 | 28  | 20  |
 |     |     |      0v |      |   | 39 || 40 | 0 | IN   | GPIO.29 | 29  | 21  |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+---Pi 400-+---+------+---------+-----+-----+
```

**Pi 1 B:**

```
gpio -v
```
```
gpio version: 2.61
Copyright (c) 2012-2018 Gordon Henderson
This is free software with ABSOLUTELY NO WARRANTY.
For details type: gpio -warranty

Raspberry Pi Details:
  Type: Model B, Revision: 00, Memory: 256MB, Maker: Egoman 
  * Device tree is enabled.
  *--> Raspberry Pi Model B Rev 1
  * This Raspberry Pi supports user-level GPIO access.
```

```
gpio readall
```
```
+-----+-----+---------+------+---+-Model B1-+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 |     |     |    3.3v |      |   |  1 || 2  |   |      | 5v      |     |     |
 |   0 |   8 |   SDA.1 |   IN | 1 |  3 || 4  |   |      | 5v      |     |     |
 |   1 |   9 |   SCL.1 |   IN | 1 |  5 || 6  |   |      | 0v      |     |     |
 |   4 |   7 | GPIO. 7 |   IN | 1 |  7 || 8  | 1 | ALT0 | TxD     | 15  | 14  |
 |     |     |      0v |      |   |  9 || 10 | 1 | ALT0 | RxD     | 16  | 15  |
 |  17 |   0 | GPIO. 0 |   IN | 0 | 11 || 12 | 0 | IN   | GPIO. 1 | 1   | 18  |
 |  21 |   2 | GPIO. 2 |   IN | 0 | 13 || 14 |   |      | 0v      |     |     |
 |  22 |   3 | GPIO. 3 |   IN | 0 | 15 || 16 | 0 | IN   | GPIO. 4 | 4   | 23  |
 |     |     |    3.3v |      |   | 17 || 18 | 0 | IN   | GPIO. 5 | 5   | 24  |
 |  10 |  12 |    MOSI |   IN | 0 | 19 || 20 |   |      | 0v      |     |     |
 |   9 |  13 |    MISO |   IN | 0 | 21 || 22 | 0 | IN   | GPIO. 6 | 6   | 25  |
 |  11 |  14 |    SCLK |   IN | 0 | 23 || 24 | 1 | IN   | CE0     | 10  | 8   |
 |     |     |      0v |      |   | 25 || 26 | 1 | IN   | CE1     | 11  | 7   |
 +-----+-----+---------+------+---+----++----+---+------+---------+-----+-----+
 | BCM | wPi |   Name  | Mode | V | Physical | V | Mode | Name    | wPi | BCM |
 +-----+-----+---------+------+---+-Model B1-+---+------+---------+-----+-----+
```

## Performance

**Pi 1 B - GC2 Turbo (1000 Hz):**

```
git clone https://github.com/GrazerComputerClub/Benchmark.git
cd Benchmark/
gcc gpio_bench.c -o gpio_bench -Wall -lwiringPi
./gpio_bench
```

```
WiringPi GPIO speed test program 
toggle 100 million times ...
  100000000 toggle took 19.556 s, Time per toggle 0.196 us, Freq 5.114 MHz 
```


Enable SPI with ``sudo raspi-config``:  
 * 3 Interface Options  
 * I4 SPI  
 * [Yes]

<!--
```
gcc spi_bench_adc.c -o spi_bench_adc -Wall -lwiringPi
./spi_bench_adc
```
-->

```
gcc spi_bench_dac-vectorgaming.c -o spi_bench_dac-vectorgaming -Wall -lwiringPi -lm
./spi_bench_adc
```

```
WiringPi SPI speed (vector gaming) test program
open device '/dev/spidev0.0' (6 MHz) ...
Pong test:
  1000 frames took 17.935 s, dots per frame 150, Time per dot 120 us, fps 56 
Space Invaders test:
  300 frames took 23.339 s, dots per frame 650, Time per dot 120 us, fps 13 
```