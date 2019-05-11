+++
showonlyimage = false
draft = false
image = "img/Raspberry-Pi-Jam.jpg"
date = "2019-05-08"
title = "Raspjamming - Raspberry Pi Jam"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = [ "Jam", "Raspberry Pi Jam", "Raspjamming", "GC2-xHAT", "HAT"]
weight = 1
+++

Als Raspjamming wird der Raspberry Pi Jam bzw. Workshop bei den Grazer Linuxtagen bezeichnet. Der Jam wird vom Grazer Computer Club, kurz GC2 organisiert. 
<!--more-->


Raspjamming bei den Grazer Linuxtagen dauert nur einen Nachmittag, das sind 3-4 Stunden. Das ist nicht viel Zeit, wenn man bedenkt, dass einige Schritte nötwendig sind um zum eigentlichen Ziel, dem Programmieren zu gelangen.  
Zum Jam gehören folgende Schritte:

 1. Hardware und Anleitungen ausgeben
 2. SD-Karte mit Betriebssystem und Programmen installieren
 3. Netzwerk bzw. WLAN einrichten (Evtl. Raspberry Pi Zero OTG Ethernet Modus aktivieren) 
 4. Librarys und Sourcecode von Git-Hub auschecken
 5. Schaltungen auf einem Steckbrett aufbauen
 6. Programmierung der Beispielaufgaben


## Anleitungen

Ganz wichtig bei einem geordneten Raspberry Pi Jam sind Anleitungen für die TeilnehmerInnen. Unsere Anleitung wurde in LaTex geschrieben und enthält Kapitel zur Systeminstallation und Projekte mit Schaltungen und Programmierbeispielen.  
Bei der Installation wurde hauptsächlich auf Linux bezug genommen, da Raspjamming bei den Grazer Linuxtagen veranstaltet wird. Microsoft Windows spezifische Teile sind in einer anderen Anleitung vorhanden. Werden aber in Zukunft auch in die Hauptanleitung übernommen.  
Die Dokumentation ist auf [Git-Hub](https://github.com/GrazerComputerClub/Raspjamming/) verfügbar und steht under der [CC-BY-SA 3.0 AT](https://creativecommons.org/licenses/by-sa/3.0/at) Lizenz.


## Raspjamming Distribution

In der Praxis hat sich gezeigt, dass auch mit einer Anleitung, die weniger vorbereiteten TeilnehmerInnen hauptsächlich mit der Einrichtung des Systems, also mit Punkt 1-3 beschäftigt waren. Diesem Umstand konnten wir entgegenwirken, indem wir ein eigenes Raspbian Image anbieten. Bei dem Image ist bereits alles eingerichtet und benötigte Programme, Bibliotheken und Source vorinstalliert. Damit erübrigt sich auch noch Punkt 4 und die TeilnehmerInnen können sich auf die Aufgaben konzentrieren.  
Wir nennen dieses Image entsprechend dem Jam "Raspjamming". Eigentlich möchten wir hier bereits von einer eigenen Distribution sprechen, die über ein [Git-Hub Repository](https://github.com/GrazerComputerClub/Raspbian-Image-Generator) verwaltet wird und automatisch erzeugt werden kann.


## GC2-xHAT Aufsteckboard

Punkt 5 wurde kontrovers diskutiert, ob nun der Aufbau von Schaltungen anhand einer Anleitung zur Aufgabe dazugehört oder nicht. Schlussendlich haben wir uns aber darauf geeinigt, dass der Hauptaugenmerk auf die Programmierung gelegt wird. Demnach haben wir einen eigenen HAT, den GC2-xHAT entwickelt. Die Bezeichnung HAT steht für "Hardware Attached on Top", also im Grunde ist es ein Aufsteckboard für den Raspberry Pi. Über die GPIO-Leiste werden so externe Komponenten an das System anschlossen.  
Auf unseren HAT sind alle Raspjamming Beispiele aufgebaut. Zusätzlich zu den Raspjamming Projekten bietet der GC2-xHAT auch noch weiter Sensoren und Möglichkeiten für erfahrenere ProgrammiererInnen. Es besteht die Möglichkeit einen ATmega328 und ESP8266 (ESP-01) Mikrocontroller zu programmieren.  
Es handle sich bei dem HAT um eine Open-Hardware. Alle Informationen, Schaltpläne sowie das Platinenlayout ist auf [Git-Hub](https://github.com/GrazerComputerClub/GC2-xHAT) frei verfügbar. Die verwendetet Lizenz ist [CC-BY 3.0 AT](https://creativecommons.org/licenses/by/3.0/at/) und  erlaubt jedwede Nutzung, nur die Namensnennung des Grazer Computer Clubs und der Lizenz muss erhalten bleiben.   
Jeder kann sich also selbst, so eine Platine fertigen lassen und auch Modifikationen durchführen.


