+++
showonlyimage = false
draft = false
image = "img/GPIOLibrary.png"
date = "2024-01-13"
title = "Raspberry Pi GPIO Librarys"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["Bookworm", "OS", "GPIO", "WiringPi", "libgpiod", "bcm2835", "pigpio"]
weight = 1
+++

Zwischen 2019 und 2024 gab es einige Änderungen beim Raspberry Pi Computer, allerdings haben viele GPIO Libarys inzwischen den Support eingestellt. Ein kurzer Überblick über den aktuellen Stand der GPIO Bibliotheken...
<!--more-->




## C


### libgpiod

Entwicklung: https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git

libgpiod ist die Offizielle GPIO Librarys für alle Linux Systeme.  
Es ist auf Raspberry Pi OS Bookmworm mit Version 1.6.3 vorinstalliert (Pakete: gpiod, libgpiod-dev, libgpiod2).  
Die Version 2 ist in Entwicklung und wird voraussichtlich eine neue API haben.
Die Library hat wenig Abstraktion und damit müssen modellspezifische Anpassungen außerhalb behandelt werden (z.B. Erkennung Pi0-4 / Pi5). Außerdem ist die Perfomrnace trotz Hochsprache C sehr bescheiden.


### Wiring Pi 


![Award](../../img/BestC.png) 

Entwicklung: https://github.com/WiringPi/WiringPi

WiringPi in Version 3 unterstützt alle Raspberry Pi Modelle und Raspberry Pi OS Bookworm. Leider ist die Library selbst nicht in Bookworm und Bullseye enthalten und muss somit manuell installiert werden. Sie ist sehr performant da direkt auf die Register für die GPIOs zugegriffen wird. Sie ist eine klare Empfehlung. 


### bcm2835

Webseite: http://www.airspayce.com/mikem/bcm2835/

bcm2835 wurde bis Raspbbery Pi 4 (2019) entwickelt und steht als Version 1.73 zur Verfügung. Es fehlt der explizite Support für Raspberry Pi Bullseye und Bookworm es dürfte aber funktionieren. 
Es ist auf Raspberry Pi OS Bookmworm mit der veralteten Version 1.71 verfügbar und kann mit ``sudo apt install libbcm2835-dev`` installiert werden.


### pigpio

Webseite: https://abyz.me.uk/rpi/pigpio/  
Entwicklung: https://github.com/joan2937/pigpio

pigpio wurde bis Raspbbery Pi 4 (2019) entwickelt. Am 2 März 2021 wurde die letzte Version v79 veröffentlicht. 
Es ist auf Raspberry Pi OS Bookmworm verfügbar und vorinstalliert (Pakete: pigpio, pigpio-tools, libpigpio-dev, libpigpio1).


## Python


### libgpiod


libgpiod, die Offizielle GPIO Librarys für alle Linux Systeme ist auch für Python 3 verfügbar. Auf Bookworm gibt es dafür das Pakete ``python3-libgpiod``.
Die aktuelle Online-Dokumention findet man unter dieser Adresse https://gpiozero.readthedocs.io/en/latest/ .


### gpiozero


![Award](../../img/BestPython.png) 

Webseite: https://gpiozero.readthedocs.io

gpiozero wurde Ende 2023 als Version 2.0 überarbeitet und unterstützt den Raspberry Pi 5. Es ist auf Raspberry Pi OS Bookmworm bereits vorinstalliert. 
Die Vorgängerversion 1.6 ist die letzte Version die noch Python 2.0 unterstützt. Aufgrund der unterstützung aller Modelle und Wartung duch die Raspberry Pi Foundation ist
sie eine klare Empfehlung. 


### Rpi.GPIO

Webseite: https://pypi.org/project/RPi.GPIO  
Entwicklung: https://sourceforge.net/p/raspberry-gpio-python/wiki/Home/


Rpi.GPIO wurde bis Raspberry Pi Zero 2 W und Raspbbery Pi 4 entwickelt. Am 6.2.2022 wurde die letzte Version 0.7.1 veröffentlicht.
Auf Bookworm stehen das Pakete ``python3-rpi.gpio`` zur Verfügung.


### pigpio

Für die Python Version der Library pigpio gilt das gleiche wie für die C Version.
Auf Bookworm stehen die Pakete ``python-pigpio`` und ``python-pigpio`` zur Verfügung.