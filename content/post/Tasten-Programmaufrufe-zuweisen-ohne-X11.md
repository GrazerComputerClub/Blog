+++
showonlyimage = false
draft = false
--image = "img/consumtion.jpg"
date = "2018-10-02"
title = "Tastaturtasten Programmaufrufe zuweisen ohne X11"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"] 
keywords = ["Taste", "Tastatur", "gpio-key", "gpio", "triggerhappy"]
weight = 1
+++


Tastaturtasten Programmaufrufe zuweisen ist eine typische Aufgabe die von diversen X11 Oberflächen zur Verfügung gestellt werden. Mit Triggerhappy steht diese Funktion aber auch in der Shell bzw. auf Systemen ohne grafischer Oberfläche zur Verfügung. So können die Multimedia-Tasten der Tastatur oder eines Laptops zum Funktionieren gebracht werden.
<!--more-->


Triggerhappy überwacht Eingaben und gedrückte Tasten und kann dann entsprechend Befehle und Programme ausführen. Es ist ein systemweiter Dienst (service), der auch ohne einer grafische Oberfäche (X11) funktioniert. Installiert wird das Programm durch die Eingabe von "apt-get install tiggerhappy", wobei es bei Raspbian allerdings bereits vorinstalliert ist.
Die Parametrierung erfolgt über Konfigurations-Dateien die sich im Verzeichnis "/etc/triggerhappy/triggers.d/" befinden müssen. Als erster wird der Ereignisname angegeben. Es ist auch möglich, bis zu 5 kombinierte Ereignisname hinzuzufügen. Sie werden die mit einem Plus-Zeichen verknüpft. Mögliche Ereignisname bzw. Eventcodes findet man auf der Seite [https://code.woboq.org/gtk/include/linux/input-event-codes.h.html](https://code.woboq.org/gtk/include/linux/input-event-codes.h.html). Dann wird der Ereigniswert (Art der Aktivierung) angegeben. Ein Wert von 1 entspricht dem Drücken einer Taste, 2 entspricht der gehaltenen Taste, die Freigabe wird durch den Wert 0 definiert. Zuletzt gibt man das auszuführende Programm an.
Eine Beispielkonfiguration für die Rasberry Pi ist das hinterlegen der Laut- und Leiser-Taste einer Multimediatastatur mit der entsprechendene Funktion. Dabei wird der PCM Audio Kanal um jeweils 2 dB verändert wenn die Taste gedrückt wird. Wird zusätzlich die linke Shift-Taste gedrückt, verändert sich der Wert um 10 dB. Dies gilt auch wenn die Taste gedrückt bleibt.

**/etc/triggerhappy/triggers.d/audio.conf**
``` 
# adjust volume
KEY_VOLUMEUP			1	/usr/bin/amixer set PCM 2dB+
KEY_VOLUMEUP			2	/usr/bin/amixer set PCM 2dB+
KEY_VOLUMEUP+KEY_LEFTCTRL 	1	/usr/bin/amixer set PCM 10dB+
KEY_VOLUMEUP+KEY_LEFTCTRL 	2	/usr/bin/amixer set PCM 10dB+
KEY_VOLUMEDOWN			1	/usr/bin/amixer set PCM 2dB-
KEY_VOLUMEDOWN			2	/usr/bin/amixer set PCM 2dB-
KEY_VOLUMEDOWN+KEY_LEFTCTRL 	1	/usr/bin/amixer set PCM 10dB-
KEY_VOLUMEDOWN+KEY_LEFTCTRL 	2	/usr/bin/amixer set PCM 10dB-
# shutdown
KEY_H+KEY_LEFTCTRL 	1	/sbin/halt
``` 

Achtung bei der Ausführung kann es zu Problemen mit den Rechten kommen. Diagnostizieren kann man es durch eine Testaktivierung und danach dem Befehl "service triggerhappy status". Dann wird am Bildschirm die Ausgabe des Programmaufrufes ausgegeben. Im Fall des Verändern der Lautstärke mit "amixer" wird die Gruppe bzw. das Recht "audio" gebraucht. Deshalb muss zuvor der Benutzer "nobody" zur Gruppe "audio" hinzugefügt werden. Dies erfolgt durch Eingabe des Befehls "adduser nobody audio".
Damit allen Benutzer das Herunterfahren erlaubt wird muss das Sticky-Bit für shutdown bzw. halt gesetzt werden, dies erfolgt mit folgenden Befehl "chmod u+s /sbin/halt".

