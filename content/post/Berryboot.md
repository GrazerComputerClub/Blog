+++
showonlyimage = false
draft = false
image = "img/PIsInABox.jpg"
date = "2018-12-17"
title = "BerryBoot"
writer = "Manfred Wallner"
categories = ["Raspberry Pi"]
keywords = ["Raspberry", "distributions", "bootloader", "berryboot"]
weight = 1
+++

Wenn man erst beginnt sich mit dem Thema Raspberry Pi auseinanderzusetzten, kann es schon mal vorkommen, dass man schlichtweg überfordert von er enormen Auswahl an unterstützten Betriebssystemen ist. Hier hilft das Projekt BerryBoot!
<!--more-->

## BerryBoot?

BerryBoot ist eine kleine Distribution, die dafür genutzt werden kann andere Betriebssysteme "live" zu installieren und starten.
Wenn man eine SD-Karte mit genügend Kapazität (16GB+ empfohlen) besitzt, kann man ohne Probleme 3,4 verschiedene Systeme gleichzeitig testen bzw. installiert haben.

## BerryBoot Beziehen

Man kann BerryBoot entweder selbst bauen, siehe Anleitung auf [GitHub](https://github.com/maxnet/berryboot), oder man lädt einfach eine vorbereitete Version von [SourceForge](http://downloads.sourceforge.net/project/berryboot/berryboot-20181211-pi2-pi3.zip) herunter.


Um BerryBoot selbst zu bauen kann man einfach den aktuellen Sourecode von GitHub auschecken und mit dem vorbereiteten Bulidscript bauen:

```
git clone https://github.com/maxnet/berryboot.git
cd berryboot

chmod +x build-berryboot.sh
./build-berryboot.sh device_pi2
```

## BerryBoot & Andere Systeme Installieren

Die erzeugten bzw. heruntergeladen und entpackten Dateien muss man lediglich auf eine SD-Karte kopieren und damit den Raspberry Pi starten.


Beim initialen Start wird was Basissystem installiert, von dort an hat man die Möglichkeit über einen grafischen Auswahldialog weitere Betriebssysteme, wie z. B. Raspbian, Ubuntu oder sogar Android installieren.



