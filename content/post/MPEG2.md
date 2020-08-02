+++
showonlyimage = false
draft = false
image = "img/mpeg2.jpg"
date = "2020-05-30"
title = "MPEG2 Video Dekodierung"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi Zero", "Raspberry Pi"]
keywords = ["decoder", "codec", "MP4", "MPEG2" , "H264", "MJPEG"]
weight = 1
+++


Seit Ende 2018 ist das Patent für den MPEG2 Hardwaredekoder fast überall auf der Welt ausgelaufen. Dennoch wurde die Funktion für den MPEG2 Video-Dekoder auf 
dem Raspberry Pi nicht freigegeben. Warum das so ist und ob es immer noch Sinn macht, soll geklärt werden...
<!--more-->

## Grundsätzliches

MPEG2 wurde 1994 als Videokodierung eingeführt und erlangte große Verbreitung, da sie bei DVD und DVB(S und T) zum Einsatz kommt. Der Raspberry Pi ist beim Dekodieren dieses Videocodecs stark belastet. Daher gab es bereits sehr früh, die Möglichkeit einen MPEG2 Hardwaredekoder bei der Raspberry Pi Foundation zu lizenzieren [MPEG-2 license key](http://codecs.raspberrypi.org/mpeg-2-license-key/).  
Ende 2018 sind die Patente in fast allen Ländern der Welt ausgelaufen. Nur noch in Malaysia und den Philippinen sind sie noch aktiv. Damit kann man MPEG2 in Europa de facto patentfrei nutzen. Allerings wurden der Dekoder nicht freigegeben und kann somit immer noch lizenzierte werden. Da die Raspberry Pi weltweit verkauft wird, gibt es keine Freigabe solange es noch irgendwo gültig ist (siehe Raspberry Pi Forum [MPEG2 patents expiring](https://www.raspberrypi.org/forums/viewtopic.php?t=201449) ).  

Es ist schon ärgerlich für Nutzer, dass der MPEG2 Hardwaredekoder nicht freigegeben wurde. Allerdings ist es fraglich ob er überhaupt noch benötigt wird. Immerhin haben die Raspberry Pi 2 bis 3+ ausreichend CPU-Leistung für eine Softwaredekodierung. Bei der Raspberry Pi 4 ist es gar nicht mehr möglich ihn freizuschalten. Hier kommt ja auch eine neue GPU im SoC zu Einsatz.  
Mam muss aber bedenken, dass der Raspberry Pi Zero noch immer verkauft wird. Darin ist der langsame alte ARM11 CPU-Kern aus den Anfangszeiten des Raspberry Pi's verbaut. Nun allerdings mit 1000 MHz und bei Übertaktung sogar 1150 MHz. Kann man nun MPEG2-Videos bzw. DVDs ruckelfrei abspielen? Ein Performance-Test soll Abklärung schaffen.   

Standardmäßig sind die Hardwaredekoder H264, H263, MPG4, MJPG und PCM aktiv. Zusätzlich lizenziert werden kann WVC1 und MPG2. 


## Performance-Test

### Verbereitung

Damit man die Videobeschleunigung nutzen kann, muss der Grafikeinheit zumindest 64 MB Speicher zugewiesen werden. Dazu muss die Zeile "gpu_mem=64" in die Konfigurationsdatei "config.txt" eingetragen werden.  
Zum Abspielen von Videos mit Hardwarebeschleunigung empfiehlt sich der omxplayer. Ansonsten kann man Videos mit dem mplayer abspielen. Hier kommt dann ein Softwaredekoder zum Einsatz. 
  
```
apt-get install omxplayer mplayer
```

Zum Testen wurde ein MPEG2-Video Datei (ohne Ton) und eine DVD verwendet. Zusätzlich wurde noch eine MJPEG-Video aus einer Kamera und zwei H264-Videos dem Test unterzogen.  
Dies wurde mit dem Raspberry Pi Zero (mit aktivem MPEG2 Hardwaredekoder) und der Raspberry Pi 2 ausgeführt.  
Bei der Softwaredekodierung wurde mplayer mit Parameter "-vo null" verwendet, um so nur die CPU-Last beim Dekodieren zu messen.

 
### Ergebnis - CPU Auslastung bei Video Dekodierung

|Video            | omxplayer (Pi Zero) | mplayer (Pi Zero) | mplayer (Pi 2) |
|-----------------|:-------------------:|:-----------------:|:--------------:|
| DVD             | 17 %                | 76 %              |                |
| MPEG2 (720x480) |  6 %                | 82 %              | 40 %           |
| MJPG (320x240)  | 11 %                | 27 %              | 20 %           |
| H264 (480x270)  |  9 %                | 56 %              | 22 %           |
| H264 (854x480)  |  9 %                | >100 %            | 56 %           |


Eine DVD kann auch bei 1150 MHz am Raspberry Pi Zero nicht ruckelfrei abgespielt werden (mplayer)! Im Test liegt die CPU-Last zwar unter 100 %, allerdings betrifft das nur die Videodekodierung. Ist die Hardwarebeschleunigung aktiv geht es sich leicht aus, die CPU-Last liegt bei ca. 17% (omxplayer). Die Raspberry Pi 2 kann die DVD ohne Probleme mit Softwaredekodierung abspielen (mplayer). Das ist auch kein Wunder, bei 4 Kernen und ca. 30 Prozent höherer Single-Core Performance. Sogar eine VNC-Verbindung lässt sich daneben auch noch betreiben.  
240p Videos lassen sich auf dem Raspberry Pi Zero durchwegs in Software dekodieren, auch der aufwendige H264 Codec. 


### Schlussfolgerung

Spielt man auf einem Raspberry Pi Zero DVDs ab, so zahlt sich der MPEG2-Dekoder definitiv aus. Spielt man nur Videos ab, so kann es sich ohne ausgehen. Dann darf aber sonst nichts am System parallel laufen. Man muss also schon sagen, dass es sehr schade ist, dass der Dekoder nicht freigegeben wurde. In Europa ist der Kauf einer MPEG2 Lizenz eigentlich überholt. Interessanterweise gibt es inzwischen einen Hack bei dem die Datei "start.elf" modifiziert wird. Danach sind allerdings alle Hardwaredekoder freigeschaltet.  
**Wer einen neueren Raspberry Pi ab 2 hat, braucht sich um MPEG2-Kodierung keine Gedanken zu machen!** 


