+++
showonlyimage = false
draft = false
image = "img/SPI-LCD-TFT2.jpg"
date = "2018-12-15"
title = "SPI TFT LCD - Teil 2"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["SPI", "TFT", "LCD", "320x240", "160x128", "128x128", "fbcp", "fbi", "/dev/fb1"]
weight = 1
+++

Hat man ein SPI TFT LCD angeschlossen und über ein Kernel Modul in das Linux System integriert, so muss man nur noch darauf zugreifen können. Das kann man entweder direkt über den Framebuffer machen oder man startet einen Dienst der die normale HDMI- oder Composite-Grafikausgabe auf das Display dupliziert. 
   
<!--more-->

## Verwendung / Grafikausgabe

## Framebuffer

Nach dem Anschließen des SPI TFT LCD und dem Laden des Kernelmoduls 'fbtft_device' wird ein zweiter Framebuffer '/dev/fb1' für das Display erzeugt. Nun kann der Framebuffer direkt angesprochen werden z. B. mit dem Programm 'fbi‘, das zur Anzeige eines Bildes verwendet wird.

```
sudo apt-get install fbi
wget https://git.io/JvgXf -O sample-128x128.jpg
sudo fbi -d /dev/fb1 -T 1 -noverbose -a sample-128x128.jpg
```

Früher konnte man mit der SDL Library 1 Spiele auf einen beliebigen Framebuffer setzen. Bei der aktuellen SDL Library Version 2 ist das nicht mehr möglich.

## Duplizierung via fbcp

Eine Alternative zum direkten Zugriff ist, den Inhalt der Grafikkarte bzw. '/dev/fb0' auf das SPI-Display bzw. '/dev/fb1' zu kopieren. Dies hat vor allem den Vorteil, dass Optimierungen und Grafikbeschleunigungen der Grafikkarte (GPU) auch für das SPI-Display funktionieren.  
Die Dekodierung von Videos passiert bei der Raspberry Pi in der GPU, so ist es auch auf der langsamen Raspberry Pi Zero möglich Video abzuspielen.
Mit dem Programm 'fbcp' kann diese ständige Kopieroperation nun im Hintergrund mit geringer CPU-Last erledigt werden. Dabei wird sogar das Bild auf die Auflösung des SPI-Displays angepasst  bzw. herunter gerechnet. Das gilt für die Konsole, für X-Windows und auch für die Videoausgabe. Man kann also auch flüssig Videos auf einem 160x128 Displays ausgeben.

**Installation:**
```
sudo -i
apt-get install cmake 
cd /usr/src
git clone https://github.com/tasanakorn/rpi-fbcp
cd rpi-fbcp/
mkdir build
cd build/
cmake ..
make
install fbcp /usr/local/bin/fbcp
exit
```

Nun kann man noch ein systemd-Service für das Programm erstellen. 

"/etc/systemd/system/fbcp.service":
```
[Unit]
Description=fbcp Service

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi
ExecStart=/usr/local/bin/fbcp

[Install]
WantedBy=multi-user.target
```

Dann kann der Dienst mit dem Aufruf ``sudo service fbcp start`` gestartet und mit ``sudo service fbcp stop`` beendet werden. Der aktuelle Status kann mit dem Befehl ``service fbcp status`` abgerufen werden.

Das Programm 'fbcp' kann permanent entweder über einen Eintrag in der Datei "/etc/rc.local" gestartet werden oder weit eleganter über einen udev-Eintrag. Dabei erfolgt der Start des Programms über den Trigger, also dem Anlegen des ‚/dev/fb1‘ Geräts.  

"/etc/udev/rules.d/80-fbcp.rules":
```
SUBSYSTEM=="graphics" ACTION=="add" ENV{DEVNAME}=="/dev/fb1", RUN+="/bin/systemctl start fbcp"
```

Als Test könnte man nun ein Video abspielen.

```
sudo apt-get install omxplayer
wget https://download.blender.org/durian/trailer/sintel_trailer-480p.mp4
fbcp &
omxplayer sintel_trailer-480p.mp4
```

## Auflösung

'fbcp' passt die Ausgabe bereits an die Auflösung des Zieldisplays an, dennoch kann es sinnvoll sein den Grafikmodus anstatt auf Full HD gleich in der nativen Auflösung des Displays zu setzen. Dazu muss man eine Custom HDMI Einstellung in der Konfigurationsdatei "config.txt" definieren. Im Beispiel wurde das "sainsmart18" Display mit 160x128 Pixel verwendet.

"/etc/modules-load.d/fbtft.conf":
```
//HDMI custom:
hdmi_cvt=160 128 60 4 0 0 0
hdmi_force_hotplug=1
hdmi_group=2
hdmi_mode=1
hdmi_mode=87
display_rotate=0
disable_overscan=1
```

Als Parameter für 'hdmi_cvt = {width} {height} {framerate} {aspect} {margins} {interlace} {rb}' stehen folgende Werte zur Verfügung:  
**width** ... Auflösung Breite  
**height** ... Auflösung Höhe  
**framerate** ... Bilder pro Sekunde  
**aspect** ... Seitenverhältnis 1=4:3, 2=14:9, 3=16:9, 4=5:4, 5=16:10, 6=15:9, 7=21:9, 8=64:27  
**margins** ...  0=margins disabled, 1=margins enabled  
**interlace** ... Bildmodus 0=progressive, 1=interlaced  
**rb** ...  0=normal, 1=reduced blanking  

Für 'display_rotate' stehen folgende Werte zur Auswahl:  
**0** ... Normal  
**1** ... 90 Grad  
**2** ... 180 Grad  


## Verlinkungen

Alle Parameter für die Video Modes der Raspberry Pi werden auf der Seite [DOCUMENTATION > CONFIGURATION > CONFIG-TXT > VIDEO](https://www.raspberrypi.org/documentation/configuration/config-txt/video.md) aufgelistet.

