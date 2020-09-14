+++
showonlyimage = false
draft = true
image = "img/Minecraft-API.jpg"
date = "2020-09-14"
title = "Minecraft Pi API"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "Raspberry Pi Zero"]
keywords = ["Raspberry Pi", "Minecraft", "Pi", "API", "Sound"]
weight = 1
+++

Wenn man Minecraft Pi installiert hat, ist auch die API also auch die Programmierschnittstelle verfügbar. Dann kann man mit wenigen Zeilen Python Sourcecode Modifikation und Erweiterungen programmieren. Wie wäre zum Anfang mit dem hinzufügen von explosivem TNT?
<!--more-->


## Grundsätzliches

Nachdem man Minecraft Pi mit dem simplen Aufruf ``sudo apt-get install minecraft-pi`` installiert hat, steht nicht nur das Spiel (Creative Mode) sondern auch die Python 3 API, also die Programmierschnittstelle, zur Verfügung. Im Grunde gibt es nur wenige Befehle, die man nutzen kann. Mehr braucht es aber auch nicht um viele spaßige Dinge umsetzen zu können. Viele programmieren Spiele im Spiel (z. B. Snake) oder erweitern es um Zusatzfunktionen. 
Eine tolle englische Anleitung bietet das MagPi Magazin Gratis Heft [Essentials Minecraft](https://magpi.raspberrypi.org/books/essentials-minecraft-v1). 

## Funktionen der API

Die Programmierschnittstelle bietet im wesentlichen folgende Funktionen:

  * Auslesen der Spielerposition
  * Setzen der Spielerposition (Teleportierung)
  * Blocktyp auslesen
  * Blocktyp setzen (Haupt und Untertyp)
  * Ereignis bei Berührung eines Blocks mit dem Schwert
  * Kameraposition ändern
  * Nachricht im Spiel anzeigen

### Initialisierung und Ausführen

Initialisiert wird die Schnittstelle mit folgendem Code

```python
from mcpi import minecraft
from mcpi import block     # need for block names
import time                # need for sleep

mc = minecraft.Minecraft.create()
```

Der Verbindungsaufbau klappt aber nur, wenn das Spiel selbst gestartet ist, der Titelbildschirm reicht nicht. Mit dem ``mc`` Objekt können dann alle Befehl ausgeführt werden. Für eine einfach Ausgabe muss man nur noch ``postToChat`` hinzufügen.

```python
mc.postToCat("Minecraft API TNT sample")
```

Der Python Sourcecode muss in eine Datei gespeichert werden, z. B. tnt.py und  mit dem Aufruf "python3 tnt.py" gestartet werden.
 

### Spielerposition

Möchte man mit Positionen arbeiten ist zu beachten:
  * X ist horizontal (links und rechts)
  * Y ist vertikal (also oben und unten)
  * Z ist in die Tiefe (hinten und vorne) 

Folgender Sourcecode teleportiert, den Spieler 4 Blocke hoch. 

```python
x, y, z = mc.player.getPos()
print("player x=%d y=%d, z=%d" % (x, y, z))
currentPlayerPos = mc.player.setPos(x, y+4, z)
```
   

### Blöcke

Blöcke zu verändern ist auch sehr leicht, dazu verwendet man die Funktion ``getBlock`` und ``setBlock``.

Folgender Sourcecode erzeugt unter dem Spieler einen TNT-Block, sofern er auf festem Untergrund steht. 

```python
Block_beneat = mc.getBlock(x, y-1, z)
if Block_beneat != block.AIR and Block_beneat != block.WATER:
  mc.setBlock(x, y, z, block.TNT.id, 1)
```

Für den Block verwenden wir das Objekt ``block`` um statt mit einer Nummer mit Namen die Böcke identifizieren zu können. Eine Liste der Blöcke bzw. Blocknamen findet man bei [Minecraft Pi Edition API Reference](https://pimylifeup.com/minecraft-pi-edition-api-reference/). Der letzte Parameter der Funktion definiert die DataId des Blockes. Diese variiert den Blocktyp. Bei TNT definiert 1 eine aktivierbaren Typ, der dann durch das Schwert zum explodieren gebracht werden kann.  
Es gibt auch die Funktion ``setblocks``, damit können mehrere Blocke auf einmal gesetzt werden. Dazu gibt man zwei Positionen an, die den zu füllenden Bereich definieren. Optional kann auch wieder die DataId Nummer angegeben werden. 

```python
  mc.setBlock(x, y, z, x, y+3, z, block.TNT)
```
   

### Ereignis bei Berührung eines Blocks (Schwert)

Eine spezielle Funktion ermöglicht es zu erkennen wenn der Spieler Blöcke mit dem Schwert (rechten Maustaste) berührt.
Die Funktion ``pollBlockHits`` holt sich diese Aktion in eine Variable. Die Feld-Variable kann dann einzeln abgearbeitet werden.
Allerdings muss man die Funktion zyklisch aufrufen. In diesem Beispiel wird für 15 Sekunden die Aktionen überwacht und eine Meldung ausgegeben. 

```python
duration=15
for loop in range(1, int(duration/0.1)):
  blockHits = mc.events.pollBlockHits()
  for hit in blockHits:
    Block_Hit = mc.getBlockWithData(hit.pos.x, hit.pos.y, hit.pos.z)
    if Block_Hit.id == block.TNT.id:
      if Block_Hit.data == 0:
        mc.postToChat("Inaktives TNT")
      if Block_Hit.data == 1:
        mc.postToChat("Aktiviere das TNT mit der linken Maustaste")
  if loop % 10 == 0:
   print("%d " % (duration-loop/10), end="", flush=True)
  time.sleep(0.1)
```



## Minecraft Pi - Sound Effects

Eine nützliche Idee hatte Martin O'Hanlon, er erweiterte das Programm um zusätzlich Soundeffekte. Das Spiel kommt nämlich im original ganz ohne Soundausgabe daher. Dazu nutzte er einfach die Python 3 API um im richten Moment Sound zu erzeugen. Zum Beispiel Schrittgeräusche beim Laufen oder bei beim Einsatz des Schwerts. Das ganze wurde in seinem Blog im Eintrag [Raspberry Pi - Minecraft - Sounds Effects](https://www.stuffaboutcode.com/2013/06/raspberry-pi-minecraft-sounds-effects.html) beschrieben. Hier wurde aber die alte Python 2 Schnittstelle verwendet, sodass es aktuell nicht mehr nutzbar ist.

Der GC2 (Grazer Computer Club) hat sich nun dem Projekt angenommen und es auf Python 3 portiert und erweitert. Es ist auf dem Github Repository [Minecraft Pi - Sound Effects](https://github.com/GrazerComputerClub/minecraft-sound) verfügbar. Einerseits ist es nützlich für Spieler und andererseits zeigt es die Möglichkeiten der Python 3 API.

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

Durch das modifizieren des Start-Scripts "/usr/bin/minecraft-pi", wird die Sound Erweiterung automatisch gestartet und beendet.

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

[Minecraft Pi Edition API Reference](https://pimylifeup.com/minecraft-pi-edition-api-reference/)  
MagPi Magazin [Essentials Minecraft](https://magpi.raspberrypi.org/books/essentials-minecraft-v1)  
Ursprungsversion von Martin O'Hanlon, [Raspberry Pi - Minecraft - Sounds Effects](https://www.stuffaboutcode.com/2013/06/raspberry-pi-minecraft-sounds-effects.html)  
GC2 Version [Minecraft Pi - Sound Effects](https://github.com/GrazerComputerClub/minecraft-sound) 

