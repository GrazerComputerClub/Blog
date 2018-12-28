+++
showonlyimage = false
draft = false
image = "img/Device-Tree.jpg"
date = "2018-12-16"
title = "Device Tree"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["SPI", "TFT", "LCD", "Device Tree", "dts", "dtb", "dtc"]
weight = 1
+++

Der vorrangige Zweck von Device Tree in Linux besteht darin, eine Möglichkeit zur Beschreibung nicht erkennbarer Hardware bereitzustellen. Zur Veranschaulichung wird für ein SPI-Displays ein Device Tree Blob erzeugt und geladen.
   
<!--more-->

## Allgemeines

Device Tree ist eine Datenstruktur zur Beschreibung von Hardware. Besonders bei ARM-Systemen kann die Hardware unterschiedlich verwendet und konfiguriert werden. Anstatt alle Details im Betriebssystem fest zu kodieren, können viele Aspekte der Hardware in einer Datenstruktur beschrieben werden, die beim Booten an das Betriebssystem übergeben wird. Der Device Tree wird für diese Aufgabe verwendet.  
Device Tree verwendet Dateien mit einer einfache Baumstruktur aus Knoten und Eigenschaften. Die Eigenschaften sind Schlüsselwertpaare, und der Knoten kann sowohl Eigenschaften als auch untergeordnete Knoten enthalten. Die Datei wird mit der Extention "dts" gespeichert.  
Mit Hilfe eines Device Tree Compilers (DTC) wird aus der dts-Datei die binäre Device Tree Blob Datei mit der Extention "dtb" erzeugen.  
Diese wird beim Bootvorgang gelesen und angewendet. Eine Vielzahl an Device Tree Blob Datei sind bereits auf der Boot-Partition im Verzeichnis "overlays" der Raspberry Pi zu finden. 

## Verwendung

Wer mit dem Raspberry Pi arbeitet hat vermutlich schon öfter mit den Device Tree Einträgen in der Konfigurationsdatei "config.txt" zu tun gehabt. 
Diese werden einfach als eigene Zeile mit ``dtoverlay={Overlay-Name},{Parameter1},{Parameter2}`` eingetragen und damit aktiviert.  
Folgendes Beispiel konfiguriert den GPIO21 als Enter-Taste wie in Blog-Eintrag "GPIO-Eingang als Tastaturtaste" bereits beschrieben wurde.
```
dtoverlay=gpio-key,gpio=21,keycode=108,label="KEY_DOWN",gpio_pull=2
```

## Erstellung

Device Tree Konfigurationen selbst zu erstellen ist natürlich möglich. Dazu muss man eine "dts" Datei erzeugen. Als Beispiel wurde ein SPI-Display mit ST7735R Chip und einer Auflösung von 160x128 erstellt, so wie Blog-Eintrag "SPI TFT LCD - Teil 1".

"st7735r.dts":
```
/*
 * Device Tree overlay for SPI TFT LCD with ST7735R chip 160x128 (1,8") 
 *
 */

/dts-v1/;
/plugin/;

/ {
	compatible = "brcm,bcm2835", "brcm,bcm2708", "brcm,bcm2709";

	fragment@0 {
		target = <&spi0>;
		__overlay__ {
			status = "okay";

			spidev@0{
				status = "disabled";
			};

		};
	};

	fragment@1 {
		target = <&spi0>;
		__overlay__ {
			/* needed to avoid dtc warning */
			#address-cells = <1>;
			#size-cells = <0>;

			sainsmart18@0{
				compatible = "sitronix,st7735r";
				reg = <0>;
				pinctrl-names = "default";

				name = "sainsmart18";
				spi-max-frequency = <48000000>;
				rotate = <90>;
				buswidth = <8>;
				fps = <50>;
				height = <160>;
				width = <128>;
				reset-gpios = <&gpio 25 0>;
				dc-gpios = <&gpio 24 0>;
				cs-gpios = <&gpio 8 0>;
				debug = <0>;
			};
		};
	};
};
```

Darin sind alle Parameter die benötigt werden, wie z. B. Kontroller, Anschlüsse, Geschwinigkeit usw. enthalten.  
Man kann sich auch Beispielkonfiguraionen von userer [Git-Hub](https://github.com/GrazerComputerClub/rpi-boot/tree/master/overlays) Seite herunterladen. Mit folgenden Device Tree Compiler Aufruf wird nun die binäre Device Tree Blob Datei erzeugt und im "overlays" Verzeichnis abgelegt.

```
wget https://github.com/GrazerComputerClub/rpi-boot/raw/master/overlays/st7735r.dts
sudo dtc -@ -I dts -O dtb -o st7735r.dtbo st7735r.dts
cp st7735r.dtbo /boot/overlays
```

Der neune Device Tree Blob kann nun in der Konfigurationdatei "config.txt" geladen werden.
```
dtoverlay=st7735r
```

Damit erspart man sich, das entsprechende Kernel Modul 'fbtft_device' zu laden und zu parametrieren. Das Display wird beim Boot bereits korrekt eingebunden  ohne, dass Anpassungen am Betriebssystem benötigt werden. 

## Verlinkungen

Alle Informationen und Parameter für den Device Tree für den Raspberry Pi sind auf der Seite [documentation > configuration > device-tree](https://www.raspberrypi.org/documentation/configuration/device-tree.md) beschrieben.

