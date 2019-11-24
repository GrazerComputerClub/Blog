+++
showonlyimage = false
draft = false
image = "img/geany.png"
date = "2019-11-10"
title = "Geany mit GTK2"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi Zero"]
keywords = ["geany", "GTK", "GTK2", "GTK3", "VTE"]
weight = 1
+++

Ab Debian 10 Buster wird Geany mit GTK3 bereitgestellt. Deshalb kann es sinnvoll sein, die alte Version mit GTK2 auf der langsamen Raspberry Pi Zero zu installieren.
<!--more-->

## Beschreibung ##

Beim Wechsel von Raspbian mit Basis Debian 9 Stretch auf Raspbian mit Debian 10 Buster gab es auch einen Wechsel bei der Entwicklungsumgebung Geany. Statt der Version 1.29 mit GTK2, wird nun die Version 1.33 mit GTK3 zur Verfügung gestellt. GTK ist eine Bibliothek für die grafische Benutzeroberflächen (GUI) mit der Fenster, Dialog und sonstige Anzeigeelemente erzeugt werden. Leider ist die Performance von GTK3 auf der Raspberry Pi Zero merklich schlechter als bei GTK2. Falls man die alte Version als zusätzliches Programm bereitstellen möchte, hier eine Anleitung.

## Installation ##

<!--
Wird ein externes Terminal Programm benutzt so können die kleinen Terminals sterm und lilyterm installiert werden. Die Umschaltung des standard X-Terminals erfolgt mit dem Befehl ``sudo update-alternatives --config x-terminal-emulator``.
-->

### Geany 1.33 GTK3

```
sudo apt-get install geany stterm libvte9 libvte-2.91-0
```

### Geany 1.29 GTK2 

```
mkdir geany
cd geany
wget http://mirror.inode.at/raspbian/raspbian/pool/main/g/geany/geany_1.29-1_armhf.deb
unp geany_1.29-1_armhf.deb
unp data.tar.xz
sudo cp usr/bin/geany /usr/bin/geany-gtk2
sudo mkdir /usr/lib/arm-linux-gnueabihf/geany-gtk2/
sudo cp -rv usr/lib/arm-linux-gnueabihf/* /usr/lib/arm-linux-gnueabihf/geany-gtk2/
mkdir common
cd common 
wget http://mirror.inode.at/raspbian/raspbian/pool/main/g/geany/geany-common_1.29-1_all.deb
unp geany-common_1.29-1_all.deb
unp data.tar.xz
sudo cp usr/share/geany/geany.gtkrc /usr/share/geany/

sudo apt-get install libfreetype6 libfontconfig1 libgtk2.0-0 libpangoft2-1.0-0
```

<!--
Error nur exe:
GTK+ 2.x symbols detected. Using GTK+ 2.x and GTK+ 3 in the same process is not supported


ldd /usr/bin/geany-gtk2 
  libgeany.so.0 => /lib/arm-linux-gnueabihf/libgeany.so.0 (0xb6cd8000)

ldd /usr/bin/geany
	libgeany.so.0 => /lib/arm-linux-gnueabihf/libgeany.so.0 (0xb6d58000)
-->

**Aufruf geany mit GTK2:**

```
LD_LIBRARY_PATH=/usr/lib/arm-linux-gnueabihf/geany-gtk2/ geany-gtk2
```

**Alias für Aufruf "~/.bash_aliases":**

```
alias geany-gtk2="LD_LIBRARY_PATH=/usr/lib/arm-linux-gnueabihf/geany-gtk2/  geany-gtk2"
alias geany-gtk3="/usr/bin/geany"
```

## Einstellungen ##

Nach der Installation gab es beim Starten eines Programms immer das Problem, dass das Terminal Programm mit dem entwickelten Programm nicht ausgeführt werden konnte.

![Fehler beim Ausführen](../../img/geany_Fehler.png) 


Das Problem kann gelöst werden indem man den internen Terminal für das Ausführen des Programms benutzt. 

Bearbeiten -> Einstellungen bzw. <kbd>Strg</kbd>+<kbd>Alt</kbd>+<kbd>P</kbd> , Reiter Terminal  
Die Optionen "Führe Programme in der VTE aus" und "Das Run-Skript nicht benutzen" müssen aktiviert werden.

![Einstellungen](../../img/geany_Einstellungen.png) 


## Performancevergleich GTK3 zu GTK2 ##

Folgende Zeit wurde ohne exakte Messung ermittelt und sind deshalb nur als Richtwert zu sehen. 

### Raspberry Pi Zero

| *Aktion*     | *GTK3 (Sek.)* | *GTK2 (Sek.)* |
|:-------------|--------|--------|
| Start        | 11     | 6      |
| Fenster öffnen: Kommandos zum Erstellen konfigurieren | 4  | 1 |
| Fenster öffnen: Einstellungen                         | 10 | 2 |
| Beenden        | 3    | 2      |


### Raspberry Pi 2

| *Aktion*     | *GTK3 (Sek.)* | *GTK2 (Sek.)* |
|:-------------|--------|--------|
| Start        | 5      | 3      |
| Fenster öffnen: Kommandos zum Erstellen konfigurieren | 2 | 1 |
| Fenster öffnen: Einstellungen                         | 6 | 2 |
| Beenden      | 2      | 1      |


### Raspberry Pi 3

| *Aktion*     | *GTK3 (Sek.)* | *GTK2 (Sek.)* |
|:-------------|--------|--------|
| Start        | 3      | 2      |
| Fenster öffnen: Kommandos zum Erstellen konfigurieren | 1 | 1 |
| Fenster öffnen: Einstellungen                         | 4 | 1 |
| Beenden      | 1      | 1      |
