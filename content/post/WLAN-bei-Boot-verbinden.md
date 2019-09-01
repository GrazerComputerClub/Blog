+++
showonlyimage = false
draft = false
image = "img/wlan-bei-boot-verbinden.jpg"
date = "2018-12-04"
title = "Raspberry Pi WLAN bei Boot verbinden"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["WiFi", "WLAN", "SSID", "wpa_supplicant", "boot", "ssh"]
weight = 1
+++

Oft ist es von Vorteil, wenn sich der Raspberry Pi gleich nach dem ersten Boot ins lokale WLAN verbindet und den SSH-Dienst startet. Dies zu konfigurieren ist ganz einfach,  ein Zugriff auf die Linux-Partition ist dazu nicht nötig.
<!--more-->


## Umsetzung

Damit sich der Raspberry Pi direkt nach dem ersten Boot ins lokale WLAN verbinden kann, müssen die Zugangsdaten in der Boot-Partition hinterlegt werden.
Man muss dort die Datei "wpa_supplicant.conf" mit folgenden Inhalt anlegen:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=AT
network={
       ssid="WLAN SSID Name"
       psk="Passwort"
       key_mgmt=WPA-PSK
} 

network={
    ssid="WLAN SSID Name - ungesichert"
    key_mgmt=NONE
}
```
Bei 'ssid=' muss unter Hochkomma der Name bzw. die SSID des WLANs angegeben werden. Bei 'psk=' wird das WLAN-Passwort angegeben. Verfügbare WLAN Netze können mit dem Befehl ``iwlist wlan0 scan | grep ESSID`` oder ``nmcli dev wifi list`` aufgelistet werden. Bei 'country=' wird das Einsatzland also 'DE' für Deutschland oder 'AT' für Österreich angegeben. Bei einem ungesicherten WLAN ohne Verschlüsselung gibt man bei 'key_mgmt=' den Typ 'NONE' ein.

Weiters darf man nicht vergessen, eine leere Datei mit dem Namen "ssh" auf der Boot-Partition anzulegen. Diese sorgt dafür, dass nach dem Boot der SSH-Dienst gestartet wird und man sich dann mit den Benutzernamen "pi" und dem Passwort "raspberry" am System anmelden kann.

Wer diese Schritte durchführt, kann ohne Monitor und Tastatur einen Raspberry Pi betriebsbereit machen und "Headless" betreiben.


## Tips

Auf einem modernen Linux mit installierten Network Manager können folgende Befehle ausgeführt werden:

***WLANs in Reichweite:*** nmcli dev wifi list  
***Aktive DNS-Server auflisten:*** nmcli dev show | grep DNS  
***Routing Tabelle:*** route


