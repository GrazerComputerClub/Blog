+++
showonlyimage = false
draft = false
image = "img/Raspjamming.png"
date = "2019-06-15"
title = "Raspjamming Distribution"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = [ "Raspbian", "Raspjamming", "Linux", "OS", "Distribution"]
weight = 1
+++

Speziell für Raspjamming, also den Raspberry Pi Jam bei den Grazer Linuxtagen wurde vom Grazer Computer Cub (GC2) eine angepasste Raspbian Lite Version  entwickelt. Diese Distribution wird Raspjamming genannt und hat wesentliche Vorteile gegenüber der Raspbian Basis.
<!--more-->

In der Praxis hat sich gezeigt, dass die weniger vorbereiteten TeilnehmerInnen des Raspberry Pi Jams, hauptsächlich mit der Einrichtung des Systems beschäftigt waren. Diesem Umstand wollten wir entgegenwirken, in dem wir ein eigenes Raspbian Image anbieten, in dem alles bereits vorinstalliert und eingerichtet ist. Wir nennen dieses Image, entsprechend dem Jam Event "Raspjamming". Eigentlich möchten wir hier bereits von einer eigenen Distribution sprechen, die über ein [Git-Hub Repository](https://github.com/GrazerComputerClub/Raspbian-Image-Generator) verwaltet wird und automatisch erzeugt werden kann. Das fertige Image kann von [Raspjamming-Image](https://github.com/GrazerComputerClub/Raspjamming-Image/releases) heruntergeladen werden.

Folgende wesentliche Änderungen gegenüber einem Raspbian Lite sind enthalten:

* Ländereinstellungen, Sprache, Tastatur und Zeitzone für Österreich
* Aktivierter SSH Zugang
* Default WLAN Zugangsdaten für Raspjamming
* Raspberry Pi Zero OTG Ethernet Gadget mit DHCP-Server 
* Schnittstellen (I2C, SPI, UART) aktiviert
* Blockly-gPIo visuelle Programmierumgebung (von GC2 entwickelt)
* Alle Raspjamming Projekte sind im Home-Verzeichnis ausgecheckt
* Webserver mit Startseite (Link zu Blockly-gPIO Entwicklungsumgebung und Raspjamming PDF-Anleitung)
* Unterstützung für GC2-xHAT (aliases)

Lästig und unpraktisch ist, dass alle Einstellungen von Raspbian auf UK bzw. Englisch gesetzt sind, hier war dringender handlungsbedarf. Der SSH-Zugang ist essentiell und musste immer manuell aktiviert werden. Primär war der Jam auf Verwendung der Raspberry Pi Zero und dem OTG Ethernet Modus ausgelegt. Die Einrichtung ist aber nichts für Anfänger. Inzwischen kann aber auch über das WLAN auf den Zero WH zugegriffen werden. Wenn das WLAN allerdings bereits voreingerichtet ist, hat man eine Fehlerquelle weniger. Problematisch ist bei diesem Betrieb, dass nicht bekannt ist, welche IP-Adresse die eigene Raspberry Pi hat. Darum wird, bei angeschlossenen GC2-xHAT die IP-Adresse angezeigt (bis eine Taste gedrückt wird). Mit dieser IP-Adresse kann man den Raspberry Pi identifizieren und sich verbinden.  
Um junge und unversierte Teilnehmer bzw. Anfänger ansprechen zu können, haben wir die visuelle Programmierumgebung [Blockly-gPIo](https://github.com/GrazerComputerClub/Blockly-gPIo) entwickelt. Durch die einfache webbasierte Schnittstelle kann man sehr schnell Aufgaben umsetzen und Programmierkonzepte erlernen.  
Die Raspjamming Beispiel Projekte werden über die Git-Hub Repositorys [Sensors-WiringPi](https://github.com/GrazerComputerClub/Sensors-WiringPi), [TM1637Display](https://github.com/GrazerComputerClub/TM1637Display)  und [net.wiringpi.sensors](https://github.com/GrazerComputerClub/wiringpi.net.sensors) bereitsgestellt. Sollte man eine der vorbereiteten Beispiele mit C, C# oder Python umsetzen wollen, sind am Raspjamming-Image bereits alle benötigten Librarys, Werkzeuge, die Entwicklungsumgebung Geany und Beispielprogramm installiert. Man kann also auch ohne Internetverbindung arbeiten und sich auf die Programieraufgaben konzentrieren. 


