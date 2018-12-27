+++
showonlyimage = false
draft = false
image = "img/Raspberry-Pi-3-A+-USB-Gadget.jpg"
date = "2018-12-23"
title = "Raspberry Pi 3 A+ USB Gadget"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["usb gadget", "ethernet", "dw"]
weight = 1
+++


Beim USB-Gadget oder OTG-Betrieb kann ein Einplatinencomputer direkt über den Micro-USB-Anschluss mit einem PC oder Laptop als Client verbunden werden. Dieser Möglichkeit ist beim Raspberry Pi Zero bereits bekannt und verbreitet. Mit dem neuen Raspberry Pi 3 A+ lässt sich der OTG-Betrieb aber auch ermöglichen. Ein paar spezielle Anpassungen sind aber nötig.
<!--more-->

## Grundsätzliches

Der Raspberry Pi Zero hat einen einzigen USB-Anschluss der direkt mit dem Prozessor verbunden ist. Dadurch kann der USB-Anschluss nicht nur als Host für USB-Geräte (Tastatur, Maus, USB-Stick) verwendet werden, sondern auch als Client. Beim Raspberry Pi 3 A+ ist das ähnlich, nur gibt es nur einen standard USB Anschluss als Typ A-Buchse. Zum Anschluss eines USB OTG Kabels mit Micro-USB Anschluss benötigt man einen Adapter oder eine andere Modifikation.  
Verwendet man einen Adapter so umgeht man die Polyfuse Sicherung am Versorgungsanschluss. Ich habe mich deshalb dazu entschlossen einen eigenen Micro-USB Anschluss aufzulöten.  
Da bei dem USB Anschluss der OTG ID Pin fehlt, ist der Anschluss eigentlich fix auf USB-Host konfiguriert. Dies kann allerdings umgangen werden indem man beim Laden des Overlays in der Konfigurationsdatei "config.txt" einen zusätzlichen Parameter mitgibt.

```
dtoverlay=dwc2,dr_mode=peripheral
```

## Zusätzlicher MicroUSB Anschluss 

Beim Erstellen eines zusätzlichen Anschluss, habe ich eine MicroUSB Breakoutboard verwendet. Auf der Rückseite der Raspberry Pi 3 A+ Platine gibt es verschiedene Lötpunkte. An den Lötpunkten kann man recht leicht ein Kabel bzw. Draht anlöten. Die Lötpunkte sind mit Nummern bezeichnet. Leider gibt es keinen Schaltplan vom Raspberry Pi 3 A+, aber die USB Kontakte sind gleich bezeichnet wie beim Raspberry Pi Zero.

| Lötpunkt | Kontakt  |
| -------- |:--------:|
| PP2      | VCC 5V   |
| PP23     | USB D-   |
| PP22     | USB D+   |
| PP5      | GND      |

Wie bereits beschrieben hätte man auch die USB Versorgung mit PP35 und PP27 verwenden können bzw. auch einen Adapter, aber dann würde man die Sicherung überbrücken.


## Stromaufnahme reduzieren

Wenn nun die Raspberry Pi im OTG-Betrieb betrieben wird, hat man noch ein Problem. Die 500 mA die eine USB-Anschluss standardmäßig bereitstellen kann, reichen nicht aus um den Raspberry Pi 3 A+ zu betreiben. Insbesonders der mit 1400 Mhz sehr hoch getaktete Prozessor benötig um einiges mehr Leistung (>750 mA).

Damit man innerhalb der Spezifikation bei der Stromaufnahme bleibt, sollte man die Taktrate auf 1000 MHz begrenzen und 2 der 4 Kerne abschalten. Dann reduziert sich die Stromaufnahme im Lastbetrieb auf beiden Kernen auf ca. 380 mA.
Dazu muss in der Konfigurationsdatei "config.txt" die Zeile ``arm_freq=1000`` eingefügt werden. In der Konfigurationsdatei "cmdline.txt" muss der Parameter `` maxcpus=2 `` eingefügt werden.  
Dennoch kann es zur Überschreitung der 500 mA Grenze kommen, wenn zusätzlich zu einer maximalen Prozessorlast auch das WLAN komplett ausgelastet wird. Dann würden im Testaufbau Stromspitzen von ca. 560 mA gemessen.  
Wenn das System auf dieser Betrieb ausgelegt werden so, darf nur noch eine Prozessorkern benutzt werden und man muss `` maxcpus=1 `` setzen. Danach wurden nur nur noch Stromspitzen bis 460 mA gemessen. 

## Fazit

Zugegeben, selbst der reduzierte Stromverbrauch ist im Vergleich zu den maximal 290 mA des Raspberry Pi Zero W schon recht viel. Aber immerhin bekommt man so fast die doppelte Prozessorleistung und eine Polyfuse für mehr Sicherheit.  
Beim Preis liegt der Raspberry Pi 3 A+ mit 25 Euro um ca. 10 Euro höher als beim Zero WH.   
Den Umbau könnte man sich sparen wenn man einen entsprechenden Adapter einsetzt (allerings dann ohne Polyfuse).  
Eine Überlegung für den nächsten Raspberry Pi Jam ist es auf jedenfall Wert.

