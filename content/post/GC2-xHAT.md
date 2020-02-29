+++
showonlyimage = false
draft = false
image = "img/GC2-xHAT.jpg"
date = "2019-06-14"
title = "GC2-xHAT Aufsteckboard"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "GC2"]
keywords = [ "Raspjamming", "GC2-xHAT", "HAT", "EEPROM"]
weight = 1
+++

Ein HAT (Hardware Attached on Top) ist ein Aufsteckboard für den Raspberry Pi. Speziell für Raspjamming, also den Raspberry Pi Jam bei den Grazer Linuxtagen wurde vom Grazer Computer Cub (GC2) ein HAT entwickelt. Dieser HAT mit dem Namen GC2-xHAT vereint viele Anfängerprojekte auf einer Platine.
<!--more-->

Die Bezeichnung HAT steht für "Hardware Attached on Top", also im Grunde ist es ein Aufsteckboard für den Raspberry Pi. Über die GPIO-Leiste werden so externe Komponenten an das System anschlossen. Für das Raspjamming Treffen, also den Raspberry Pi Jam bei den Grazer Linuxtagen, sollte Mithilfe eines eigens entwickelten HATs eine einsteigerfreundliche Hardware zur Verfügung gestellt werden. Dieser HAT vereint deshalb viele Anfängerprojekte auf einer Platine. So können Jam TeilnehmerInnen sich auf das wesentliche konzentieren, die Programmierung. Der Name dieses HAT ist GC2-xHAT. Zusätzlich zu den Raspjamming Projekten bietet der GC2-xHAT auch noch weiter Sensoren und Möglichkeiten für erfahrenere ProgrammiererInnen.

Folgende Sensoren und Hardware sind am GC2-xHAT enthalten:

* 7-Segment Display mit 4 Stellen
* DHT11 o. DHT22 o. AM2302 Luftdruck / Luftfeuchte Sensor
* AMD2320 o. AMD2322 Luftdruck / Luftfeuchte Sensor
* DS18B20 Temperatursensor
* HC-SR04 Ultraschalldistanzsensor
* 3 x LED (Rot, Orange, Grün für Ampelfunktion)
* 3 x Schalter
* Summer (Buzzer)
* ATmega 328P Sockel für Programmierung und Testen
* ESP-01 (ESP8266) Sockel für Programmierung und Testen
* HAT EEPROM 

Es handle sich bei dem HAT um eine Open-Hardware. Alle Informationen, Schaltpläne sowie das Platinenlayout ist auf [Git-Hub](https://github.com/GrazerComputerClub/GC2-xHAT) frei verfügbar. Die verwendetet Lizenz ist [CC-BY 3.0 AT](https://creativecommons.org/licenses/by/3.0/at/) und erlaubt jedwede Nutzung, nur die Namensnennung des Grazer Computer Clubs und der Lizenz muss erhalten bleiben. Jeder kann sich also selbst, so eine Platine fertigen lassen und auch Modifikationen durchführen.  

Bei den Daten zum HAT ist auch eine EEPROM-Konfiguration dabei. Diese sollte in den Speicherchip des HAT programmiert werden. Wie das geht wird in Kapitel [HAT EEPROM anschließen und konfigurieren](../hat-eeprom/) beschrieben.  
Weiters ist eine [alias Konfiguration](https://github.com/GrazerComputerClub/GC2-xHAT/blob/master/aliases/bash_aliases_GC2xHAT) enthalten die Shell-Kommandos für die Steuerung des GC2-xHAT enthält:

* **redon**/**rotein** ... Rote LED einschalten
* **redglow**/**rotglimmen** ... Rote LED leicht leuchten lassen
* **redoff**/**rotaus** ... Rote LED ausschalten
* **ledon**/**ledein** ... Alle LEDs (Rot, Orange und Grün) einschalten
* **ledoff**/**ledaus** ... Alle LEDs (Rot, Orange und Grün) ausschalten
* **beep**/**piep** ... Summer kurz aktivieren
* **esppoweron** .. 3,3 V Versorgung für ATmega328- und ESP01-Sockel einschalten
* **esppoweroff** .. 3,3 V Versorgung für ATmega328- und ESP01-Sockel ausschalten
* usw.

An einfachsten ist allerdings die Nutzung mit der GC2 Distribution [Raspjamming](https://github.com/GrazerComputerClub/Raspjamming-Image). Dann sind die benötigen Werkzeuge und aliases Einträge bereits vorinstalliert. Zum Programmieren des EEPROM kann ein aktuelles [Image](https://github.com/GrazerComputerClub/Raspjamming-Image/releases) verwendet werden. 
Mehr Informationen zur [Raspjamming Distribution](../raspjamming-distribution/) findet man im entsprechenden Kapitel.

## Schaltplan

![Schaltplan GC2-xHAT](https://raw.githubusercontent.com/GrazerComputerClub/GC2-xHAT/master/circuit_diagram.png)
