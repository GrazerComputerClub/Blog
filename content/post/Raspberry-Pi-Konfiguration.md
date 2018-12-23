+++
showonlyimage = false
draft = false
image = "img/config-txt.jpg"
date = "2018-12-07"
title = "Raspberry Pi Konfiguration mit 'config.txt'"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["config.txt", "Konfiguration", "include", "filter"]
weight = 1
+++


Jeder Raspberry Pi Nutzer kennt wohl die Konfigurationsdatei "config.txt" auf der Boot-Partition des Raspberry Pis.
Allerdings gibt es einige Befehle und Möglichkeiten die nicht jedem bekannt sind. 
<!--more-->

## Allgemeines

Anders als bei jeder anderen System werden Parametrierungen bei dem Raspberry Pi über die Datei "config.txt" vorgenommen. Die Datei liegt auf der 
ersten Partition, die mit dem Windows FAT Dateisystem formatiert ist. Dadurch kann sie sehr leicht auch aus einem Windows System verändert werden.
Es ist nur darauf zu achten, dass man die Datei mit einem Editor öffnet, der mit einem Linux Zeilenumbruch (LF statt CR-LF) umgehen kann. Ich empfehle [Notepad++](https://notepad-plus-plus.org/download/), obwohl der integrierte Notepad Editor von Windows 10 nun auch endlich diese [Funktion](https://blogs.msdn.microsoft.com/commandline/2018/05/08/extended-eol-in-notepad/) beherrscht. **\o/**


## Spezielle Konfiguationsmöglichkeiten
 
Eine Auflistung der gängigsten Parametrierungen erspare ich mir, die gibt es bereits unzählige Male im Internet zu finden. 
Bei der Raspberry Pi Foundation gibt es zum Beispiel umfassende Informationen bei [documentation > configuration > config-txt](https://www.raspberrypi.org/documentation/configuration/config-txt/). Ich möchte mich auf weniger bekannte Möglichkeiten konzentrieren.

### Include 

Über die Anweisung **include** können zusätzliche Textdateien für die Konfiguration eingebunden werden. Damit kann man zum Beispiel über eine einzelne Zeile 
eine Vielzahl an Parametrierungen hinzufügen und auch wieder leicht entfernen.

```
#include OverclockPiZero.txt
include SPIDisplaySettings.txt
```

### Filter

Bedingte Einstellungen können über **Filter** realisiert werden, und gelten somit nur unter bestimmten Umständen. Der Filter wird in eckigen Klammern angegeben *[ ]*. *[all]* deaktiviert den Filter. Als Filter kann verwendet werden:
* Raspberry Pi Variante (Pi 3, Pi Zero usw.)
* [EDID](https://de.wikipedia.org/wiki/Extended_Display_Identification_Data) Kennung des Monitors
* Seriennummer des Raspberry Pis
* GPIO Zustand

Die Kombination von Filtern ist auch möglich. Damit sind viele spezielle Einsatzgebiete möglich. 

Beim der **Raspberry Pi Variante** muss nur der Kurzname des Raspberry Pi in eckigen Klammern angegeben werden. Alle nachfolgenden Einstellungen gelten dann nur für diese Raspberry Pi Variante.

**[pi1]** ... Raspberry Pi 1 (A, A+, B, B+)   
**[pi2]** ... Raspberry Pi 2  
**[pi3]** ... Raspberry Pi 3, Compute Module 3  
**[pi3+]** ... Raspberry Pi 3+  
**[pi0]** ... Pi Zero, Pi Zero W  
**[pi0w]** ... Pi Zero W  
**[all]** ... Filter wird aufgehoben

Beispiel:
```
[pi0]
# Overclock Pi Zero (W)
arm_freq=1030
core_freq=500
sdram_freq=500
[all]
```

Beim der **Seriennummer**, muss man die Raspberry Pi Seriennummer mit "0x" ohne vorlaufenden Nullen in eckigen Klammern angeben. Die Seriennummer wird mit dem Befehl
`cat /proc/cpuinfo | grep Serial` ermittelt. 
```
Serial		: 0000000012345678
```

Beispiel:
```
[0x12345678]
# UART defect
enable_uart=0
[all]
```

Beim Filter über **GPIO Zustand**, muss man in eckigen Klammern die GPIO-Nummer (BCM) und den Zustand (1=3,3V; 0=GND) angegeben. Zum Beispiel könnte man so einen Schalter zum Umschalten des Video-Modes integrieren. 

Beispiel:
```
[gpio4=1]
# GPIO 4 switch to 720p60 HDMI Mode
hdmi_mode=4
disable_overscan=1
[all]
```

## Konfigurationen auslesen 

Wenn Raspbian Linux gestartet ist, können die Einstellungen der "config.txt" Konfigurationsdatei mit dem Befehl `vcgencmd get_config int` aufgelistet werden.

**Raspberry Pi Zero:**
```
aphy_params_current=547
arm_freq=1000
audio_pwm_mode=514
config_hdmi_boost=5
core_freq=400
disable_auto_turbo=1
disable_commandline_tags=2
display_hdmi_rotate=-1
display_lcd_rotate=-1
dphy_params_current=547
force_eeprom_read=1
force_pwm_open=1
framebuffer_ignore_alpha=1
framebuffer_swap=1
gpu_freq=300
hdmi_force_cec_address=65535
hdmi_group=1
hdmi_mode=1
ignore_lcd=1
init_uart_clock=0x2dc6c00
over_voltage_avs=0x249f0
overscan_bottom=32
overscan_left=32
overscan_right=32
overscan_top=32
pause_burst_frames=1
program_serial_random=1
sdram_freq=450
```

**Raspberry Pi 3 A+:**
```
aphy_params_current=819
arm_freq=1400
audio_pwm_mode=514
config_hdmi_boost=5
core_freq=400
desired_osc_freq=0x331df0
desired_osc_freq_boost=0x3c45b0
disable_commandline_tags=2
disable_l2cache=1
display_hdmi_rotate=-1
display_lcd_rotate=-1
dphy_params_current=547
force_eeprom_read=1
force_pwm_open=1
framebuffer_ignore_alpha=1
framebuffer_swap=1
gpu_freq=300
hdmi_force_cec_address=65535
init_uart_clock=0x2dc6c00
lcd_framerate=60
over_voltage_avs=62500
over_voltage_avs_boost=0x27ac4
overscan_bottom=48
overscan_left=48
overscan_right=48
overscan_top=48
pause_burst_frames=1
program_serial_random=1
sdram_freq=450
```
