+++
showonlyimage = false
draft = false
image = "img/Bookworm.png"
date = "2024-02-01"
title = "Raspberry Pi OS Bookworm"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["Bookworm", "OS"]
weight = 1
+++

2023 wurde Raspberry Pi OS auf die aktuelle Debian Basis 12 aktualisiert und trägt somit den Namen Bookworm. Dadurch hat sich einiges geändert, hier eine kleine Auflistung.
<!--more-->

## Beschreibung 

Raspberry Pi OS Bookworm basiert auf Debian 12 und verwendet einen 6.1 Kernel.
Es gab vorallem 3 große Änderungen, bei der grafischen Oberfläche, Audio und Netzwerk. 

Genaue Information kann man im englischen original Nachlesen.  
  -  https://www.raspberrypi.com/news/bookworm-the-new-version-of-raspberry-pi-os/
  -  https://wiki.debian.org/NewInBookworm


## Grafik


Bei der Grafischen Oberfläche wird nicht länger auf X11 gesetzt sondern auf das neue Wayland. Das gilt vorallem für den Raspberry Pi 4 / 400 und 5.
X11 ist inzwischen schon 35 Jahre alt und nicht mehr auf der Höhe der Zeit.  Allerdings wird es dür die alten Raspberry Pis immer noch empfohlen.
Wayland bringt mehr Sicherheit, denn die Kommunikation erfolgt isoliert für die Programme. Als Komposer wird  Wayfire verwendet (früher Mutter Window Manager). Bei X11 wird Openbox als Window Manager verwendet. Programme können im übrigen bei Wayland nicht mehr so wie bei X11 über das Netzwerk remote gestartet werden, es muss eine VNC-Programm benutzt werden.


Weitere Keine Änderungen sind:
 - Die Toolbar ist nun wf-panel-pi statt lxpanel. 
 - Leider funktioniert VNC bei 32-Bit nicht mehr
 - Der Firefox Browser hat einige Optimierungen bekommen 
 - grim ist das Standard Screenshot Programm 


## Audio

PipeWire wird nun statt PulseAudio verwendet.
Teilweise gibt es noch Probleme mit alten Applikationen wie z. B.  Sonic Pi. 
Bei der Lite Version ohne GUI ist aber immer noch Alsa im Einsatz.

## Netzwerk

Beim Netzwerk wird nun Network Manager (https://networkmanager.dev/) für die Verwaltung aller Netzwerk-Geräte und Einstellungen verwendet.  
Früher wurde dhcpd verwendet.  
Das hat auch Auswirkungen auf die Einrichtung von WLAN. Am besten man man nun dies über das Konfigurationsprogramm rasp-config.
Zur Analyse kann man das Konsolenprogram "nmcli" verwenden.

```bash
  nmcli dev wifi list
```  

```
  IN-USE  BSSID              SSID          MODE   CHAN  RATE        SIGNAL  BARS  SECURITY 
  *       00:01:E3:0D:83:8F  WLAN1         Infra   11   130 Mbit/s     91        WPA2     
          A0:21:B7:AC:AA:34  WLAN2         Infra   1    195 Mbit/s     62        WPA2     
          F6:F2:6D:9C:A5:AC  WLAN3         Infra   1    195 Mbit/s     60        WPA2     
```


```bash
  nmcli con show
```

```
NAME                UUID                                  TYPE      DEVICE 
Wired connection 1  a9035b46-e5f0-39ce-a168-1ff1c9c27829  ethernet  eth0   
lo                  3a249178-4599-4ae1-ae15-d9505322a972  loopback  lo     
WLAN1               f29f22f9-41ce-208d-af82-a9f2e754394a  wifi      wlan0  
```




## Sonstiges

Die zentrale Systemprotokoll-Datei /var/log/syslog gibt es nun nicht mehr! Stattdessen wird nun journalctl verwendet um Zugriff auf das Systemprotokoll zu bekommen.
Gibt man ``journalctl`` ein, so wir das gesamte Protokoll ausgegeben. Das ist aber viel zu viel für eine sinnvolle Diagnose. ``journalctl -b`` zeigt alles seit dem letzten Bootvorgang. Es gibt noch viele andere Parameter die man über die Hilfe ``man journalctl`` nachlesen kann. 

### /proc/cpuinfo

Beim alten Raspberry Pis (Zero, P1, P3) ändert sich bei "/proc/cpuinfo" nichts zwischen Kernel 5 und Kernel 6. Manche sind vielleicht verwirrt weil bei Hardware immer die CPU BCM2835 ausgewiesen wird. Anders soieht es aber beim Raspberry Pi 4 aus. Dort ist die Zeile "Hardware" komplett verschwunden. Das kann zu Probleme führen wenn Programme dies erwarten, wie z.B. die WiringPi Library bis Version 2.70! Zur analysie kann man den Befehl ``WIRINGPI_DEBUG=1 gpio readall`` ausführen.  

Im Fehlerfall sieht das dann so aus.
```
Oops: Unable to determine board revision from /proc/cpuinfo
 -> No "Hardware" line
 ->  You'd best google the error to find out why.
```

Unter Model steht in "/proc/cpuinfo" aber immer das konkrete Raspberry Pi Modell. Bei Revision steht eine bitcodierte Hex-Zahl die alle Informationen wie Modell, Revision, Hersteller, RAM Größe usw. enthält (siehe https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#raspberry-pi-revision-codes). 

**Raspberry Pi 1:**

```
Hardware	: BCM2835
Revision	: 0002
Serial		: 00000000dc5813d0
Model		: Raspberry Pi Model B Rev 1
```

**Raspberry Pi 3:**

```
Hardware	: BCM2835
Revision	: 9020e0
Serial		: 000000004202fabc
Model		: Raspberry Pi 3 Model A Plus Rev 1.0
```

**Raspberry Pi 4:**

```

Revision	: c03111
Serial		: 100000002eb65c54
Model		: Raspberry Pi 4 Model B Rev 1.1
```

Man kann die Revision- und Serial-Nummer aber auch über den Device-Tree binär auslesen:

```
hexdump -C /proc/device-tree/system/linux,revision

00000000  00 c0 31 11
```


```
hexdump -C  /proc/device-tree/system/linux,serial 
00000000  10 00 00 00 2e b6 5c 65
```

**Raspberry Pi 5:**
```
Revision	: c04170
Serial		: f1d12b5630430cca
Model		: Raspberry Pi 5 Model B Rev 1.0
```
```
hexdump -C /proc/device-tree/system/linux,revision
00000000  00 c0 41 70  
```
```
hexdump -C  /proc/device-tree/system/linux,serial 
00000000  f1 d1 2b 56 30 43 0c cf
```

### GPIO Sysfs

Bei Support für die GPIO Sysfs hat sich bis zu Raspberry Pi 5 noch nichts geändert. Hier steht ja im Raum, dass die überholte ABI "GPIO Sysfs Interface for Userspace" https://www.kernel.org/doc/Documentation/gpio/sysfs.txt bald aus dem Kernel gelöscht wird. Im aktuell verwendeten Kernel 6.1 ist das aber noch nicht der Fall und somit ändert sich für die Funktion und GPIO-Librays vorerst nichts. Allerdings muss zum GPIO (BCM)Nummer noch 399 hin zugezählt werden. Also GPIO04 ist über 403 ansprechbar (siehe https://forums.raspberrypi.com/viewtopic.php?t=359302).



**Raspberry Pi 0-4:**

Anzahl der verfügbaren GPIOs
```
cat /sys/class/gpio/gpiochip0/ngpio
```
```
58
```

Ansprechen einen GPIO

```
echo 4 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio4/direction
echo 1 > /sys/class/gpio/gpio4/value
echo 0 > /sys/class/gpio/gpio4/value
```



<!--


    Testen:

 - screenshot tool


stop console

sudo service serial-getty@ttyAMA0 stop
sudo screen /dev/ttyAMA0 115200


-->


