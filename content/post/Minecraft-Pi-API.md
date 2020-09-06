+++
showonlyimage = false
draft = true
image = "img/Minecraft-API.jpg"
date = "2020-08-24"
title = "Minecraft Pi API"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "Raspberry Pi Zero"]
keywords = ["Raspberry Pi", "Minecraft", "Pi", "API"]
weight = 1
+++

Wenn man Minecraft Pi installiert hat, ist auch die API also auch die Programmierschnittstelle verfügbar. Dann kann man mit wenigen Zeilen Python Source Modifikation und Erweiterungen programmieren. Wie wäre zum Anfang mit dem hinzufügen von Musik, Sound und explosivem TNT. 
<!--more-->


## Grundsätzliches

Nachdem man Minecraft Pi mit dem simplen Aufruf von ``sudo apt-get install minecraft-pi`` installiert hat, steht nicht nur das Spiel (Creative Mode) sondern auch die Python 3 API, also die Programmierschnittstelle, zur Verfügung. Im Grunde gibt es nur wenige Befehle, die man nutzen kann. Mehr braucht es aber auch nicht um viele spaßige Dinge umsetzen zu können. Viele programmieren Spiele im Spiel oder erweitern es. 
Eine tolle englische Anleitung bietet das MagPi Magazin Gratis Heft [Essentials Minecraft](https://magpi.raspberrypi.org/books/essentials-minecraft-v1).


## Minecraft Pi - Sound Effects

Eine nützliche Idee hatte Martin O'Hanlon, er erweiterte das Programm um zusätzlich Soundeffekte. Das Spiel kommt nämlich im original ganz ohne Soundausgabe daher. Dazu nutzte er einfach die Python 3 API um im richten Moment Sound zu erzeugen. Zum Beispiel Schrittgeräsche beim Laufen oder bei beim Einsatz des Schwerts. Das ganze wurde in seinem Blog im Eintrag [Raspberry Pi - Minecraft - Sounds Effects](https://www.stuffaboutcode.com/2013/06/raspberry-pi-minecraft-sounds-effects.html) beschrieben. 
Hier wurde aber die alte Python 2 Schnittstelle verwendet, sodass es aktuell nicht mehr nutzbar ist.

Der GC2 hat sich nun dem Projekt angenommen und es auf Python 3 portiert und erweitert. Es ist auf dem Github Repository [Minecraft Pi - Sound Effects](https://github.com/GrazerComputerClub/minecraft-sound) verfügbar. Einereits ist es nützlich für Spieler und andererseits zeigt es die Möglichkeiten der Python 3 API.

Folgende Änderungen wurden durchgeführt:

  * Portierung auf Python 3
  * Nur Public Domain Sounddateien
  * Neue Sounddateien für (platschen, schwimmen, fliegen)
  * Hintergrund Musik
  * Sonstige Optimierungen 
  * Umwandlung von TNT auf explosives TNT (Aktivierung durch das Schwert)
  * Erweiterung aktiviert sich nach dem Laden einer Karte (oder bei einem Absturz) automatisch 


## Installation

Zur Installation lädt man sich die Letztversion vom Repository herunter und startet das Python 3 Programm zusammen mit Minecraft. 

```
cd ~
mkdir minecraft-sound
cd minecraft-sound
wget https://github.com/GrazerComputerClub/minecraft-sound/archive/0.3.zip
unzip 0.3.zip
cd minecraft-sound-0.3
```

Durch das modifizieren des Start-Scripts "/usr/bin/minecraft-pi", wird die Sound Erweiterung automatisch gestartet.

```
#!/bin/sh

cd /home/pi/git/minecraft-sound
python3 minecraft-sound.py &
PID=$! 
echo Minecraft Sound process PID is $PID

cd /opt/minecraft-pi || exit

if grep -q okay /proc/device-tree/soc/v3d@7ec00000/status \
	/proc/device-tree/soc/firmwarekms@7e600000/status 2> /dev/null; then
	export LD_PRELOAD=libbcm_host.so.1.0
	export LD_LIBRARY_PATH=lib/mesa
else
	export LD_LIBRARY_PATH=lib/brcm
fi

./minecraft-pi
echo stopping Minecraft Sound process
kill -KILL $PID
```



## Beispielvideo für explosives TNT 

[![Minecraft Pi Explosive TNT mod](http://img.youtube.com/vi/iVHuY5olYWo/0.jpg)](https://www.youtube.com/watch?v=iVHuY5olYWo)

## Verlinkung

Ursprungsversion von Martin O'Hanlon, [Raspberry Pi - Minecraft - Sounds Effects](https://www.stuffaboutcode.com/2013/06/raspberry-pi-minecraft-sounds-effects.html)  
MagPi Magazin [Essentials Minecraft](https://magpi.raspberrypi.org/books/essentials-minecraft-v1)  
GC2 Version [Minecraft Pi - Sound Effects](https://github.com/GrazerComputerClub/minecraft-sound) 


