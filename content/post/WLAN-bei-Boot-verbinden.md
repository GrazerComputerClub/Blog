+++
showonlyimage = false
draft = false
image = "img/wlan-bei-boot-verbinden.jpg"
date = "2018-09-16"
title = "WLAN bei Boot verbinden"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["Taste", "Tastatur", "gpio-key", "gpio"]
#tags = ["", ""]
weight = 1
+++


## Zusammenfassung

Oft ist es von Vorteil wenn sich der Raspberry Pi gleich nach dem ersten Boot ins lokale WLAN verbindet und den SSH-Dienst startet. Dies zu konfigurieren ist ganz einfach. Ein Zugriff auf die Linux-Partition ist dazu nicht nötig.

## Umsetzung

Damit sich der Raspberry Pi direkt nach dem ersten Boot ins lokale WLAN verbinden kann, müssen die Zugangsdaten in der Boot-Partition hinterlegt werden.
Man muss dort die Datei 'wpa_supplicant.conf' mit folgenden inhalt anlegen:

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
Bei 'ssid=' muss unter Hochkomma der Name des WLANs angegeben werden. Bei 'psk=' wird das WLAN-Passwort angegeben. Bei 'country=' wird das Einsatzland also 'DE' für Deuschland oder 'AT' für Österreich angegeben. Bei einem ungesicherten WLAN ohne Verschlüsselung gibt man bei 'key_mgmt=' den Typ 'NONE' ein.

Weiters darf mann nicht vergessen, eine leere Datei mit dem Namen 'ssh' auf der boot-Partition anzulegen. Sie sorgt dafür, dass nach dem Boot der SSH-Dienst gestaret wird und man sich dann mit den Benutzernamen 'pi' und dem Passwort 'raspberry' am System anmelden kann.

Wer diese Schritte duchführt kann ohne Monitor einen Raspberry Pi inbetriebnehmen und 'Headless' betreiben.

## Verlinkungen

Weitere Infos bezüglich der DeviceTree Funktion ‚gpio-keys‘, erhält man unter [https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-keys.txt](https://www.kernel.org/doc/Documentation/devicetree/bindings/input/gpio-keys.txt) 




