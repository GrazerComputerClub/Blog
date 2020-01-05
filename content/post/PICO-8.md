+++
showonlyimage = false
draft = false
image = "img/PICO-8.jpg"
date = "2018-12-21"
title = "PICO-8"
writer = "Martin Strohmayer"
categories = ["Programmierung", "Raspberry Pi"]
keywords = ["Retro", "lua", "GameDev"]
weight = 1
+++


Wer sich gerne einmal mit Retro-Spieleprogrammierung (GameDev) beschäftigen will, dem aber C64, GB und NES Tools zu kompliziert sind, sollte sich unbedingt einmal PICO-8 ansehen. Diese "virtuelle Konsole" mit einer integriertem Entwicklungsumgebung, bietet alles was man zur Spieleprogrammierung benötigt. Dabei läuft sie nicht nur auf dem PC, sondern auch auf dem Raspberry Pi.
<!--more-->

## Grundsätzliches

PICO-8 ist eine erfundene „Fantasy Console“ die am PC (Windows, Linux, MacOS) und auf dem Raspberry Pi emuliert werden kann. Es handelt sich um ein kommerzielles Produkt, das von Lexaloffle Games entwickelt wird. Die Programmierung erfolgt in Lua. Mithilfe der integrierten Entwicklungsumgebung können Source, Musik, Sound, Sprites und Maps erstellen werden.  
Der reguläre Preis beträgt 14,99 US Dollar (ca. 14 Euro). Bei einem Game-Jam bzw. im Schulungsbereich kann es gratis benutzt werden. Nach der Schulung können die Teilnehmer vergünstigt eine "Take-home license" erwerben.  

## Installation

PICO-8 läuft auch auf einem Raspberry Pi Zero (1000 MHz), wobei hier schon die Grenze erreicht ist. Es hängt auch etwas von den Spielen ab, aber die von mir getesteten liefen knapp unter 100% CPU-Last. Als Basis wurde eine Raspbian Buster mit installierter WiringPi Library (apt-get install wiringpi) verwendet.  
Nach dem Kauf kann man sich die Zip-Datei "pico-8_0.1.12c2_raspi.zip" herunterladen. Darin ist das Verzeichnis "pico-8" mit allen Dateien. Es enthält zwei ausführbare Dateien "pico8" und "pico8_dyn". Bei "pico8_dyn" wird die SDL2 Library in Version 2.0 dynamisch gelinkt. Das bedeutet also sie muss am System bereits installiert sein. "pico8" benötigt die SDL-Library nicht, weil sie statisch gelinkt wurde. Ich empfehle "pico8" zu Ausführung zu verwenden. Allerdings gibt es auch hier einige Abhängigkeiten zu Bibliotheken. Eine davon ist die WiringPi Library für den GPIO Zugriff. Wieso diese benötigt wird später noch erläutert.  
Achtung, wenn der Fehler "pico8: error while loading shared libraries: libsndio.so.6.1: cannot open shared object file: No such file or directory" auftritt, dann wurde die veraltete Version 0.1.12c gestartet. Bitte unbedingt die Version 0.1.12c2 benutzen. Falls das nicht geht, kann folgener Trick angewendet werden:

```
sudo apt-get install libsndio7.0
sudo ln -s /usr/lib/arm-linux-gnueabihf/libsndio.so.7.0 /usr/lib/arm-linux-gnueabihf/libsndio.so.6.1
```

<!--
Version 0.1.11:
	/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so => /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so (0xb6f72000)
	libm.so.6 => /lib/arm-linux-gnueabihf/libm.so.6 (0xb6ef0000)
	libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0xb6edd000)
	libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0 (0xb6eb3000)
	librt.so.1 => /lib/arm-linux-gnueabihf/librt.so.1 (0xb6e9c000)
	libbcm_host.so => /opt/vc/lib/libbcm_host.so (0xb6e72000)
	libwiringPi.so => /lib/libwiringPi.so (0xb6e54000)
	libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xb6d06000)
	/lib/ld-linux-armhf.so.3 (0xb6f85000)
	libvchiq_arm.so => /opt/vc/lib/libvchiq_arm.so (0xb6cf0000)
	libvcos.so => /opt/vc/lib/libvcos.so (0xb6cd7000)
	libcrypt.so.1 => /lib/arm-linux-gnueabihf/libcrypt.so.1 (0xb6c97000)


Version 0.1.12c1:
	/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so => /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so (0xb6f23000)
	libm.so.6 => /lib/arm-linux-gnueabihf/libm.so.6 (0xb6ea1000)
	libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0xb6e8e000)
	libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0 (0xb6e64000)
	librt.so.1 => /lib/arm-linux-gnueabihf/librt.so.1 (0xb6e4d000)
	libbcm_host.so => /opt/vc/lib/libbcm_host.so (0xb6e23000)
	libwiringPi.so => /lib/libwiringPi.so (0xb6e05000)
	libsndio.so.6.1 => /lib/arm-linux-gnueabihf/libsndio.so.6.1 (0xb6de6000)
	libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xb6c98000)
	/lib/ld-linux-armhf.so.3 (0xb6f36000)
	libvchiq_arm.so => /opt/vc/lib/libvchiq_arm.so (0xb6c82000)
	libvcos.so => /opt/vc/lib/libvcos.so (0xb6c69000)
	libcrypt.so.1 => /lib/arm-linux-gnueabihf/libcrypt.so.1 (0xb6c29000)
	libasound.so.2 => /lib/arm-linux-gnueabihf/libasound.so.2 (0xb6b48000)
	libbsd.so.0 => /lib/arm-linux-gnueabihf/libbsd.so.0 (0xb6b20000)

Version 0.1.12c2:
	/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so => /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so (0xb6f3b000)
	libm.so.6 => /lib/arm-linux-gnueabihf/libm.so.6 (0xb6eb9000)
	libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0xb6ea6000)
	libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0 (0xb6e7c000)
	librt.so.1 => /lib/arm-linux-gnueabihf/librt.so.1 (0xb6e65000)
	libbcm_host.so => /opt/vc/lib/libbcm_host.so (0xb6e3b000)
	libwiringPi.so => /lib/libwiringPi.so (0xb6e1d000)
	libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xb6ccf000)
	/lib/ld-linux-armhf.so.3 (0xb6f4e000)
	libvchiq_arm.so => /opt/vc/lib/libvchiq_arm.so (0xb6cb9000)
	libvcos.so => /opt/vc/lib/libvcos.so (0xb6ca0000)
	libcrypt.so.1 => /lib/arm-linux-gnueabihf/libcrypt.so.1 (0xb6c60000)
-->

## Technische Daten

**Auflösung:** 128 x 128 Pixel  
**Bilder pro Sekunde (FPS):** 30 oder 60  
**Farben:** 16 Farben (Palette unter CC0 freigegeben, [download](https://lospec.com/palette-list/pico-8))  
**Modul (Cartridge) Größe:** 32 kB  
**Tasten:** D-PAD, 2 Aktionstasten (X und O), Menütaste  
**Sound**: 4 Kanal, 64 definierbare Chip Sounds  
**Limitierungen:**  Sprites (128 8x8 Pixel), Maps (128x32 Zellen), Source (8192 Tokens)  

### Palette

![PICO-8 Palette](../../img/PICO-8-Palette.png)

### Tastenzuordnung

Pause: Enter bzw. P

**Steuerung Player 1:**  
D-PAD: Steuerkreuz  
Aktionstaste 1 (O): Z bzw. N  
Aktionstaste 2 (X): N bzw. M  

**Steuerung Player 2:**  
D-PAD = S D E F  
Aktionstaste 1 (O): Tab bzw. Shift  
Aktionstaste 2 (X): Q bzw. A  

### Modul (Catridge)

Vielfach wird beim Programmspeicher von Cartridge, also von einem Spielmodul gesprochen wie man es von GB, NES usw. kennt. Bei der Cartridge handelt es sich allerdings um eine PNG-Bilddatei. Das erstellte Programm kann also in einer Grafikdatei gespeichert werden. Diese Datei enthält dann ein Vorschaubild als auch das Spiel selbst als Zusatzdaten.


## Programmierung  


![PICO-8 Gameplay](../../img/PICO-8-Gameplay.png)


### Sourcecode Ausschnitt als Beispiel

```
FUNCTION MOVEPADDLE()
  IF BTN(0) THEN
    IF PADX>=STEP THEN
      PADX-=STEP
    ELSE
      PADX=0
    END
  ELSEIF BTN(1) THEN
    IF PADX+PADW<=127-STEP THEN
      PADX+=STEP
    ELSE
      PADX=127-PADW
	  END
  END
END

FUNCTION _UPDATE()
  MOVEENEMY()
  MOVEPADDLE()
  BOUNCEBALL()
  BOUNCEBUMPER()
  BOUNCEPADDLE()
  MOVEBALL()
  CHECKENEMYHIT()
END

FUNCTION _DRAW()
  CLS()
  FOREACH(BUMPERS, DRAW_BUMPER)
  DRAW_ENEMY()
  RECTFILL(PADX,PADY,PADX+PADW,PADY+PADH,15)
  PRINT("TIME="..CEIL(TIME()).."S",0,122,12)
  PRINT("LIVE="..LIVE,40,122,12)
  PRINT("USS YOU'RE "..ENEMY_HEALTH.."%",70,122,12) 
  CIRCFILL(BALLX,BALLY,BALLSIZE,6)
END
```
### Raspberry Pi

Für den Raspberry Pi enthält PICO-8 eine Besonderheit. Auf die ersten 8 GPIOs ([WiringPi Nummerierung](http://wiringpi.com/pins/)) kann direkt zugegriffen werden. Es können also Eingänge gelesen oder Ausgänge auf High oder Low gesetzt werden. Die GPIOs sind dabei auf die Adressen 0x5f80 bis 0x5f87 verfügbar. Will man den ersten GPIO auf High (3,3 V) setzen so muss man mit dem Befehl 'poke' den Wert 255 auf Adresse 0x5f80 zuweisen. Der Wert 0 setzt den Ausgang auf Low (GND).  
Mit dem Befehl 'peek' dient zum Einlesen des Zustands des GPIOs.

**Blinklicht auf zwei GPIOs:**
```
TIMER=0

FUNCTION _UPDATE()
  TIMER = TIMER+1
  IF TIMER>=60 THEN
    TIMER = 0
  END
  IF TIMER==30 THEN
    POKE(0X5F80,255)
    POKE(0X5F87,255)
  ELSEIF TIMER==0 THEN
    POKE(0X5F80,0)
    POKE(0X5F87,0)
  END
END
```

## Pi-XO Spielkonsole

Der GC2 hat in einem Projekt, eine kleine Gameboy Advance ännliche Handheld-Konsole entwickelt. Sie ist speziell für PICO-8 geeignet und nennt sich Pi-XO. Sie besteht aus einem Raspberry Pi Zero und einer Platine mit Tasten, einem SPI-Display und Soundausgabe. Mit den ersten 8 GPIOs können Vibrationsmotoren und LEDs aktiviert werden. Weitere Informationen findet man auf der [GitHub Projektseite](https://github.com/GrazerComputerClub/Pi-XO). 

[![Pi-XO Gaming](http://img.youtube.com/vi/vgGREFB0JgY/0.jpg)](https://www.youtube.com/watch?v=vgGREFB0JgY)


## Verlinkungen 

### Pi-XO

[GitHub Pi-XO](https://github.com/GrazerComputerClub/Pi-XO) 

### PICO-8

Offizielles PICO-8 [Handbuch](https://www.lexaloffle.com/pico8_manual.txt)  
Bezug [PICO-8](https://www.lexaloffle.com/pico-8.php?#getpico8)  
Vergünstigte Lizenz [PICO-8 for Educators](https://www.lexaloffle.com/pico-8.php?page=schools)  
PICO-8 [Palette](https://lospec.com/palette-list/pico-8)

### Englische Handbücher für den Einstieg

[Gamedev with PICO-8](https://mboffin.itch.io/gamedev-with-pico-8-issue1)  
[PICO-8 Fanzine #1](https://sectordub.itch.io/pico-8-fanzine-1)  
[PICO-8 Fanzine #2](https://sectordub.itch.io/pico-8-fanzine-2)  
[PICO-8 Fanzine #3](https://sectordub.itch.io/pico-8-fanzine-3)  
[PICO-8 Fanzine #4](https://sectordub.itch.io/pico-8-fanzine-4)

