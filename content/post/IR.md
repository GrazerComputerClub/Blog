+++
showonlyimage = false
draft = true
image = "img/IR.jpg"
date = "2019-11-03"
title = "IR-Empfänger"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["IR", "infrarot", "GPIO"]
weight = 1
+++

Mit einem günstigen IR-Empfänger lässt sich über einen GPIO-Pin, Kommandos mit einer IR-Fernbedienung am Raspberry Pi auslösen. Nachdem der Kernel in Raspbian aktualisert wurde hat sie Einbindung aber verkompliziert. Wie es richtig geht erfahrt man hier... 
<!--more-->

## Beschreibung ##

Über einen GPIO Pin lässt sich eine IR-Empfängerbauteil z.B. den Typ TSOP4838 ganz leicht an den Raspberry Pi anschließen. Zusätzliche Bauteile werden nicht benötigt. So lassen sich über eine IR-Fernbedienung Kommandos am System ausführen. Leider hat sich mit dem letzten 4er Kernel bei Raspbian Strech und Buster einiges geändert, sodass viele Anleitungen im Internet nicht mehr funktieren. Das neue Kernel-Modul benutzt nun ein anderes Protokoll wodurch der [LIRC - Linux Infrared Remote Control](http://www.lirc.org/) Dienst nun nicht mehr korrekt funktioniert. Es bedarf eines Patch (Softwareänderung) des LIRC Programms um den korrekten Betrieb zu gewährleisten.
 

## Anschluss ##

Der IR-Sensor TSOP4838 funktioniert mit 2,5 bis 5,5 V und kann somit direkt mit 3,3 V versorgt werden. Pin 1 (links) ist ist dabei die Versorgung VCC. An Pin 2 (mitte) wird GND angeschlossen. Der Signal-Ausgang ist dann auf Pin 3 der direkt an einen frei wählbaren GPIO angeschlossen wird (z. B. GPIO18).  

![IR-Sensor Schaltplan](../../img/IR_Schaltplan.png) 

![IR-Sensor Steckplatine](../../img/IR_Steckplatine.png) 


## Installation ##

Es muss lediglich ein Devicetree Eintrag in der Konfigurationsdatei "config.txt" eingefügt werden, damit das entsprechende Kernelmodul geladen wird. Als Paramter wird der verwendetet GPIO angegeben.

```
dtoverlay=gpio-ir,gpio_pin=18
```

Nach einem Neustart kann der Lirc installiert werden.

```
apt-get install lirc
```

Der Dienst startet allerdings nicht, da die Parametrierung fehlt. 


## Parametierung ##

```

Zuerst sollte man überprüfen ob das Kernel Modul korrekt geladen wurde und damit das lirc-Device vorhanden ist. 
```
ls /dev/lirc* 
```
Als Ausgabe sollte man "/dev/lirc0" finden.  
Beispielkonfigurationen für lirc wurden bereits abgelegt, müssen aber noch umbenannt bzw. umkopiert und modifiziert werden.

```
sudo cp /etc/lirc/lirc_options.conf.dist /etc/lirc/lirc_options.conf
sudo cp /etc/lirc/lircd.conf.dist /etc/lirc/lircd.conf
sudo cp /etc/lirc/irexec.lircrc.dist /etc/lirc/irexec.lircrc
sudo cp irexec.lircrc.dist /home/pi/.lircrc
```

In der Datei "/etc/lirc/lirc_options.conf" müssen folgenden Zeile angepasst werden (Werte sind anders gesetzt).

```
    driver = default
    device = /dev/lirc0
```

```
sudo service lircd restart
```

Nun könnte man den IR-Empfänger bereits mit "mode2" und einer beliebigen Fernbedienung testen.

```
mode2
```

Bei einem Tastdruck werden Pulsedauer bzw. Pulsfolgen ausgegeben.  
Allerdings ist eine Programmierung oder Verwendung noch nicht möglich!


## lirc-Dienst anpassen ##

Leider versteht der lirc Dienst das Kernel Modul nicht korrekt und muss deshalb modifiziert werden.
Wie das Funktioniert wird im Raspberry Pi Forum im Beitrag [Using LIRC with kernel 4.19.X and gpio-ir](https://www.raspberrypi.org/forums/viewtopic.php?p=1438740&sid=1a1aa370b94e5b2f20158d64d1b0b254#p1438740) beschrieben.  

Hier wird nur die Buster Anleitung aufgeführt:

```
sudo su -c "grep '^deb ' /etc/apt/sources.list | sed 's/^deb/deb-src/g' > /etc/apt/sources.list.d/deb-src.list"
sudo apt update
sudo apt install devscripts

sudo apt remove lirc liblirc0 liblirc-client0

sudo apt install dh-exec doxygen expect libasound2-dev libftdi1-dev libsystemd-dev libudev-dev libusb-1.0-0-dev libusb-dev man2html-base portaudio19-dev socat xsltproc python3-yaml dh-python libx11-dev python3-dev python3-setuptools
mkdir build
cd build
apt source lirc
wget https://raw.githubusercontent.com/neuralassembly/raspi/master/lirc-gpio-ir-0.10.patch
patch -p0 -i lirc-gpio-ir-0.10.patch
cd lirc-0.10.1
debuild -uc -us -b
cd ..
sudo apt install ./liblirc0_0.10.1-5.2_armhf.deb ./liblircclient0_0.10.1-5.2_armhf.deb ./lirc_0.10.1-5.2_armhf.deb 
```


< Anleitung in Arbeit ... >
