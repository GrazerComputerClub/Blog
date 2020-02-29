+++
showonlyimage = false
draft = false
image = "img/Raspberry-Pi-Jam.jpg"
date = "2019-06-16"
title = "Raspjamming - Raspberry Pi Jam"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "GC2"]
keywords = [ "Jam", "Raspberry Pi Jam", "Raspjamming", "GC2-xHAT", "HAT"]
weight = 1
+++

Als Raspjamming wird der Raspberry Pi Jam bzw. Workshop bei den Grazer Linuxtagen bezeichnet. Der Workshop wird vom Grazer Computer Club, kurz GC2 organisiert.
<!--more-->

Raspjamming bei den Grazer Linuxtagen dauert nur einen Nachmittag, das sind 3-4 Stunden. Das ist nicht viel Zeit, wenn man bedenkt, dass einige Schritte nötwendig sind um zum eigentlichen Ziel, dem Programmieren zu gelangen.  
Zum Jam gehören folgende Schritte:

 1. Hardware und Anleitungen ausgeben
 2. SD-Karte mit Betriebssystem und Programmen installieren
 3. Netzwerk bzw. WLAN einrichten (Evtl. Raspberry Pi Zero OTG Ethernet Modus aktivieren)
 4. Librarys und Sourcecode von Git-Hub auschecken
 5. Schaltungen auf einem Steckbrett aufbauen
 6. Programmierung der Beispielaufgaben

## Hardware

Beim Workshop 2018 hatten wir einige TeilnehmerInnen die keinerlei Materialien mitgebracht hatten. Um möglichst vielen die Möglichkeit zu geben an Raspjamming teilnehmen zu können stellen wird Hardware zum Ausleihen zur Verfügung.  
Das sind hauptsächlich auf Grund des Preises Raspberry Pi Zero WH Einplatinencomputer. Sie sind bereits mit einem Pin-Header bestückt und bieten auch WLAN als Verbindungsoption. Wenngleich die CPU-Leistung und Features limitiert sind, haben wir damit gute Erfahrungen gemacht.  
Für die Programmierprojekte stellen wir kleine Steckplatinen, Kabel und eine LED mit Vorwiderstand zur Verfügung. Zusätzlich gibt es noch eine Ampel und weiter Sensoren und Hardware für die vorbereitet Projekte.

## Anleitungen

Ganz wichtig bei einem geordneten Raspberry Pi Jam sind Anleitungen für die TeilnehmerInnen. Unsere Anleitung wurde in LaTex geschrieben und enthält Kapitel zur Systeminstallation und Projekte mit Schaltungen und Programmierbeispielen.  
Inzwischen sind die relevanten Teile für die Einrichtung des Systems sowie die Programme für die Verbindungsaufnahme für Linux und Windows verfügbar.  
Die Dokumentation ist auf [Git-Hub](https://github.com/GrazerComputerClub/Raspjamming/releases) verfügbar und steht unter der [CC-BY-SA 3.0 AT](https://creativecommons.org/licenses/by-sa/3.0/at) Lizenz.

## Raspjamming Distribution

In der Praxis hat sich gezeigt, dass auch mit einer Anleitung, die weniger vorbereiteten TeilnehmerInnen hauptsächlich mit der Einrichtung des Systems, also mit Punkt 1-3 beschäftigt waren. Diesem Umstand konnten wir entgegenwirken, indem wir ein eigenes Raspbian Image anbieten. Bei dem Image ist bereits alles eingerichtet und benötigte Programme, Bibliotheken und Source vorinstalliert. Damit erübrigt sich auch noch Punkt 4 und die TeilnehmerInnen können sich auf die Aufgaben konzentrieren.  
Wir nennen dieses Image entsprechend dem Jam "Raspjamming". Eigentlich möchten wir hier bereits von einer eigenen Distribution sprechen. Mehr Informationen zu diesem Betriebssystem erhält man beim Kapitel [Raspjamming Distribution](../raspjamming-distribution/).

## GC2-xHAT Aufsteckboard

Punkt 5 wurde kontrovers diskutiert, ob nun der Aufbau von Schaltungen anhand einer Anleitung zur Aufgabe dazugehört oder nicht. Schlussendlich haben wir uns aber darauf geeinigt, dass der Hauptaugenmerk auf die Programmierung gelegt wird. Darum haben wir einen eigenen HAT, den GC2-xHAT entwickelt.
Die Bezeichnung HAT steht für "Hardware Attached on Top", also im Grunde ist es ein Aufsteckboard für den Raspberry Pi. Mehr Informationen zu dieser Hardware erhält man beim Kapitel [GC2-xHAT Aufsteckboard](../gc2-xhat/).
