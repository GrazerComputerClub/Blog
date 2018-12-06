+++
showonlyimage = false
draft = false
image = "img/gpio-shutdown.jpg"
date = "2018-12-03"
title = "Raspberry Pi über GPIO-Eingang herunterfahren"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["shutdown", "herunterfahren", "gpio-shutdown", "gpio"]
weight = 1
+++

Leider fehlt den Raspberry Pi Einplatinencomputern eine Taste zum ordnungsgemäßen Herunterfahren des Systems. Doch das Nachrüstung dieser Funktion geht ganz einfach. Man benötigt nur einen Schalter, Kabel und einen Eintrag in der Konfigurationsdatei "config.txt".
<!--more-->

## Umsetzung

Bekanntlich besitzt der Raspberry Pi keinen Ausschaltknopf, der ein Herunterfahren des System auslösen kann. Diese Funktion nachträglich einzubauen ist aber sehr einfach möglich. Man muss lediglich einen Taster an einen GPIO-Eingang hängen und einen Devicetree Eintrag in der Konfigurationsdatei "config.txt" einfügen. Verantwortlich für die Funktion ist die Funktion 'gpio-shutdown'.

``
dtoverlay=gpio-shutdown
``

Ohne Parametrierung wird eine Shutdown ausgelöst, wenn der GPIO3 auf Low bzw. GND gesetzt wird. Achtung, der GPIO3 gehört zur I2C-Schnittstelle und sollte also nur für den Shutdown verwendet werden, wenn I2C nicht verwendet wird. Möchte man die Funktion mit einem anderen GPIO verwenden, so muss man die entsprechenden Parameter angeben.

``
dtoverlay=gpio-shutdown,gpio_pin=5,active_low=1,gpio_pull=up
``

Parameter für gpio-shutdown Overlay:

| Parameter     | Funktion |
| ------------- |----------|
| gpio_pin      | GPIO-Nummer (BCM), 3 ist Standard-Einstellung     |
| gpio_pull     | Aktivierung Pull-up/Pull-down Widerstand; off = Keiner; down = Pull-down; up = Pull-up (Standard-Einstellung)   |
| active_low    | Logikpegel für Tastendruck; 0 = Active High, Schalter verbindet nach 3,3 V; 1 = Active Low (Standard-Einstellung), Schalter verbindet nach GND     |

Der Taster führt im übrigen bei nochmaliger Aktivierung zu einem erneuten Startvorgang.

Nicht verwechseln darf man den Devicetree Eintrag mit 'gpio-poweroff'. Dieser dient zum Aktivieren eines Ausgangs wenn sich der Raspberry Pi im Zustand "Halt" befindet. Hier gibt es den Parameter 'gpiopin' falls der Standard Ausgang GPIO26 nicht gewünscht ist.

``
dtoverlay=gpio-poweroff,gpiopin=20
``

Parameter für gpio-poweroff Overlay:

| Parameter     | Funktion |
| ------------- |----------|
| gpiopin       | GPIO-Nummer (BCM); 26 ist Standard-Einstellung     |
