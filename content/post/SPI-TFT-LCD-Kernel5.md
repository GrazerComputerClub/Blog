+++
showonlyimage = false
draft = false
image = "img/SPI-LCD-TFT-fbcp-ili9341.jpg"
date = "2020-11-09"
title = "SPI TFT LCD - Kernel 5"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["SPI", "TFT", "LCD", "320x240", "160x128", "128x128", "240x240", "ST7735", "ST7789", "ILI9341"]
weight = 1
+++

Für eine Anzeige abseits von HDMI und Composite bieten sich günstige SPI TFT LCDs an. Diese gibt es in unterschiedlichen Auflösungen und Größen. Die Einbindung ist seit Kernel 5 nicht mehr über das Kernelmodul fbtft möglich. Man kann aber das Programm fbcp-ili9341 nutzen.
<!--more-->

## Allgemeines

SPI-Displays sind TFT-LCD-Anzeigen, die über den SPI-Bus an den Raspberry Pi angeschlossen werden können. Sie werden in unterschiedlichsten Auflösungen (128x128, 160x128, 240x240, 320x240 usw.) und Größen (1,44“ - 2,8“ usw.) angeboten. Es gibt allerdings verschiedenste Kontroller für diese SPI-Displays, die unterschiedlich angesprochen werden. Früher konnte man sie über ein Kernel Modul  bzw. Overlay einbinden. Seit Kernel 5 ist dass aber nur mehr über entsprechende Overlays möglich. In userem Test funktionierten die Oberlays allerdings auch nicht obwohl sie mit Kernel 4 korrekt gearbeitet haben.  

Als Alternative bietet sich das Projekt [fbcp-ili9341](https://github.com/juj/fbcp-ili9341) an. Das Programm muss zuerst mit Kompilerparameter an das Display und die Verkabelung angepasst werden. Desweiteren können noch einige weitere Anpassungen vorgenommen werden. Das Programm kann entsprechend des Zielsystems bzw. dem Raspberry Pi optimiert werden. Wir wählen die Anpassung an den Raspberry Pi Zero, damit es mit allen Systemen verwendet werden kann.  
Nach dem Kompilieren bzw. Erstellen des Programms kanne es gestartet werden. Dann zeigt das SPI-Display die Grafikausgabe des Raspberry Pi an. Es kopiert also den Inhalt der Grafikkarte auf das Display und skaliert es entsprechend um. Dies hat vor allem den Vorteil, dass Optimierungen und Grafikbeschleunigungen der Grafikkarte (GPU) auch für das SPI-Display funktionieren.  
Die Dekodierung von Videos passiert bei der Raspberry Pi in der GPU, so ist es auch auf dem langsamen Raspberry Pi Zero möglich Video abzuspielen.  
Mit dem Programm 'fbcp-ili9341' kann diese ständige Kopieroperation nun im Hintergrund mit geringer CPU-Last erledigt werden. Dabei wird sogar das Bild auf die Auflösung des SPI-Displays angepasst. Das gilt für die Konsole, für X-Windows und auch für die Videoausgabe. Man kann also auch flüssig Videos auf einem 160x128 Displays ausgeben.

Günstige SPI-Displays mit einem unterstützten Kontroller sind z. B.:

| Kontroller | Auflösung | Größe | ca. Preis China |
| -----------|:---------:|:-----:|:---------------:|
| ST7735S  |	128x128 | 1,44"    |  3 €  |
| ST7735R | 160x128 | 1,8"     |  4 €  |
| ST7789VW | 240x240 | 1,3"     |  3 €  |
| ILI9341	          |	320x240 | 2,2-2,8" |  8 €  |

Ein Problem stellt die Framerate dar, weil der SPI-Bus des Controllers nur eine limitierte Übertagungsrate unterstützt. Bei den kleinen Displays sind dann durchaus 30 FPS (Bilder pro Sekunde) möglich. Bei 320x240 sind bei der Raspberry Pi Zero allerdings nur 10-20 FPS möglich.  
Die theoretische minimale nötige Übertragungsrate bzw. SPI-Taktfrequenz kann man sich für 25 FPS und 16 Bit Farben leicht berechnen. Bei einer Auflösung von 160x128 ergibt sich eine Übertragungsrate von min. 8 MBit/s (8 MHz). Bei 320x240 allerdings bereits 41 MBit/s (41 MHz).  
Die SPI-Taktfrequenz wird aus dem System Takt als der "core_freq" gebildet. Man muss hier den entsprechenden geradzahligen Divisor als Parameter angeben. Bei typischerweise 400 MHz Takt wird mit dem Divisor 8 also 50 MHz und mit Divisor 6 wird 66 MHz erzeugt.  
Im Test lag nämlich die maximale SPI-Taktfrequenz des ST7735R-Controllers bei ca. 50 MHz (Divisor 8) und beim ILI9341-Controller bei ca. 66 MHz.
Der SPI-Bus kann nicht parametriert werden, es wird immer SPIO verwendet. Es wird auch empfohlen den SPI Bus in der Datei config.txt zu deaktivieren, damit es keine Probleme und Wechselwirkungen gibt.  

Auf der Projektseite sind alle Parameter genau beschreiben. Bei Unklarhieten muss hier nachgelesen werden.


## Kontakte

Zur Ansteuerung des Displays werden folgende Kontakte bzw. GPIOs verwendet:  
**VCC** ... Versorgung (meist 5 oder 3,3 V)  
**VLED** ... Versorgung Hintergrundbeleuchtung (optional, meist 3,3 V)  
**GND** ... Masse  
**MOSI** ... Datenleitung  
**CLK** ... SPI-Takt  
**CS** ... SPI Slave Aktivierung  
**RESET** ... Reset  
**DC/A0/RS** ... Umschaltung Befehl oder Daten Übertagung  

Die Kontakte RESET und DC/A0/RS können über Parameter frei zugewiesen werden. Wobei CS immer auf CS0 gesetzt werden muss. RESET wird auf GPIO25 und DC/A0/RS auf GPIO24. MOSI und CLK werden auf die entsprechenden SPI-Bus Anschlüsse verbunden.

![SPI-LCD-TFT Anschluss](../../img/SPI-LCD-TFT_Steckplatine.png)

## Erstellung für 1,8" 160x128 Display mit ST7735R Kontroller

```
sudo apt-get install cmake
cd ~
git clone https://github.com/juj/fbcp-ili9341.git
cd fbcp-ili9341
mkdir build
cd build
cmake -DST7735R=ON -DGPIO_TFT_DATA_CONTROL=24 -DGPIO_TFT_RESET_PIN=25 -DSPI_BUS_CLOCK_DIVISOR=8 -DSINGLE_CORE_BOARD=ON -DARMV6Z=ON -DSTATISTICS=0 -DDISPLAY_ROTATE_180_DEGREES=ON ..
make -j
 ```

Mit ``sudo ./fbcp-ili9341`` kann das Programm dann gestartet werden.

## Verlinkungen

GitHub Projekt [fbcp-ili9341](https://github.com/juj/fbcp-ili9341)

