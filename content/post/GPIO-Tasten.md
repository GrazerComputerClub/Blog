+++
showonlyimage = false
draft = false
image = "img/keys_white_nav.jpg"
date = "2018-12-10"
title = "GPIO-Eingang als Tastaturtaste"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["Taste", "Tastatur", "gpio-key", "gpio"]
weight = 1
+++


Oft sollen per GPIO-Taste Programme gesteuert werden. Früher musste man das kompliziert mit einem eigenen Programm oder zusätzlicher Hardware realisieren. Doch nun geht das ganz einfach, über Devicetree. Mit nur einem Eintrag in der Konfigurationsdatei "config.txt" wird ein GPIO-Eingang einer Tastatur-Taste zugewiesen.
<!--more-->

## Umsetzung

Mithilfe der Devicetree Funktion 'gpio-key' können ganz einfach GPIO-Eingänge zur Simulation eines Tastaturtastendrucks verwendet werden. Man kann so zum Beispiel einem Steuerkreuz die Pfeiltasten Rechts, Links, Oben und Unten zuweisen. Dazu muss man nur angeben welcher GPIO-Eingang welche Taste bzw. Tastencode entspricht. Die Tastencodes können live mit dem Konsolenprogramm 'showkey' ermittelt werden, wenn eine Tastatur angeschlossen ist. Wird 10 Sekunden keine Taste gedrückt, so beendet sich das Programm von selbst.

| Taste         | Scancode |
| ------------- |:--------:|
| Pfeil oben    | 103      |
| Pfeil links   | 105      |
| Pfeil rechts  | 106      |
| Pfeil unten   | 108      |
| Esc           | 1        |
| Backspace     | 14       |
| Enter         | 28       |
| Strg links    | 29       |
| Space         | 57       |
| a   | 30     |
| s   | 31     |
| d   | 32     |
| w   | 17     |
| y   | 44     |
| x   | 45     |
| c   | 46     |
| z   | 21     |
| p   | 28     |

Alternativ kann auch das Programm 'dumpkeys' mit dem Aufruf ``sudo dumpkeys -f > dumpkeys.txt`` verwendet werden um eine ganze (unübersichtliche) Liste zu erstellen.  
Eine Liste ist auch im Internet bei den [Kernel-Sourcen](https://github.com/torvalds/linux/blob/v4.12/include/uapi/linux/input-event-codes.h) verfügbar.
Hier sind auch einige Spezialtasten bzw. Tasten mit bereits verknüpften Funktionen zu finden. 

| Name          | Scancode | Funktion |
| ------------- |:--------:|:--------:|
| KEY_POWER     | 166      | Shutdown |
| KEY_RESTART   | 408      |          |
| KEY_RFKILL    | 247      |          |

Folgende DeviceTree Einträge weisen beispielsweise den angegeben GPIOs die Pfeiltastenfunktionen zu:

```
dtoverlay=gpio-key,gpio=16,keycode=103,label="KEY_UP",gpio_pull=2
dtoverlay=gpio-key,gpio=26,keycode=105,label="KEY_LEFT",gpio_pull=2
dtoverlay=gpio-key,gpio=20,keycode=106,label="KEY_RIGHT",gpio_pull=2
dtoverlay=gpio-key,gpio=21,keycode=108,label="KEY_DOWN",gpio_pull=2
```

Parameter für gpio-key Overlay:

| Parameter     | Funktion |
| ------------- |----------|
| gpio          | GPIO-Nummer (BCM)  |
| keycode       |  Tastencode        |
| label         |  Beliebiger Name   |
| gpio_pull     |  Aktivierung Pull-Up/Pull-Down Widerstand; 0 = keiner; 1 = pull-down; 2 = pull-up     |
| active_low    |  Logikpegel für Tastendruck; 0 = Active High, Schalter verbindet nach 3,3 V; 1 = Active Low (Standard-Einstellung), Schalter verbindet nach GND     |


Auf der Kommandozeile kann die Funktion durch folgenden Befehl getestet werden:
```
sudo dtoverlay gpio-key gpio=19 keycode=28 label="KEY_ENTER" gpio_pull=2
```

## Verlinkungen

Weitere Infos bezüglich der DeviceTree Funktion ‚gpio-keys‘, erhält man unter [https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-keys.txt](https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-keys.txt) 




