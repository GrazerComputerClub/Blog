+++
showonlyimage = false
draft = false
image = "img/Raspberry-Pi-Zero-WH.jpg"
date = "2023-10-29"
title = "Raspberry Pi Zero Shopping Guide"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi Zero"]
keywords = ["Pi", "Zero", "Zero 2", "W", "WH", "V1.3", "Shop", "semaf", "berrybase"]
weight = 1
+++

Zuerst würden 3 Variante des Raspberry Zero verkauft. Im Herbst 2021 wurde der langerwartete Zero 2 veröffentlicht. Somit gibt es nun 4 Varianten des Raspberry Pi Zero  ...
<!--more-->

<!-- v0 date = "2018-12-05" -->
<!-- v1 date = "2022-10-25" -->
<!-- v2 date = "2022-10-25" -->
<!-- v3 date = "2023-06-30" -->

#
## Die vier Varianten des Raspberry Pi Zero

Der **Raspberry Pi Zero V1.3** ist am günstigsten zu haben. Der Preis lag bis 2023 bei 5 Pfund (ca. 6 Euro). Ab 2023 liegt er nun effektiv bei ca. 12 Euro. Er kann allerdings pro Bestellung nur einmal gekauft werden. In Wahrheit kommt aber zum Preis noch der Versand dazu. Diese Version hat im Gegensatz zu älteren Versionen einen Kameraanschluss. Dieser ist allerdings gegenüber des normalen Raspberry Pi verkleinert. Entweder man setzt ein spezielles Adapterkabel ein oder man Kauf eine Kamera die bereits das entsprechende Kabel besitzt. Die GPIO-Pins sind nicht bestückt. Dies muss bei Bedarf manuell erfolgen.

Der **Raspberry Pi Zero W** hat zusätzlich zur V1.3 noch WLAN und Bluetooth dabei. Der WLAN Chip (Broadcom BCM43143) entspricht dem Chip der Raspberry Pi 3 Modell B. Es wird das 2,4 GHz Band mit Standard 802.11b/g/n unterstützt. Bei Bluetooth wird Version 4.1 LE (Low Energy) unterstützt. Der Preis lag bis 2023 bei 10 Pfund bzw. ca. 12 Euro. Ab 2023 liegt er nun effektiv bei ca. 18 Euro! Wieder kann pro Bestellung nur maximal ein Stück gekauft werden. Damit erhöht sich in Wahrheit der Preis noch um den Versand.

Der **Raspberry Pi Zero WH** hat zusätzlich zur W Version eine Stecker- oder Buchsenleiste bei den GPIOs verlötet. Diese Variante kann unlimitiert bestellt werden. Der Preis lag bis 2023 bei 15 Pfund bzw. ca. 15 Euro. Ab 2023 liegt er nun bei ca. 19 Euro!

Der **Raspberry Pi Zero 2 W** hat gegenüber dem Raspberry Pi Zero W eine wesentlich bessere CPU. Hier kommt ein BCM2710A1 SOC zum Einsatz, der eine niedrig getaktet CPU Variante des Raspberry Pi 3 enthält. Damit hat der Zero 2 nun auch vier Cortex-A53 Kerne die mit 1000 MHz getaktet sind. Dadurch ist er 64-Bit fähig und leidet nicht an den Kompatibilitätsproblemen des ARM11 mit armv6-Architektur. Bei Bluetooth unterstützt er nun auch Version 4.2 BLE so wie der Raspberry Pi 3. Zu beachten ist allerdings, dass der Grundverbrauch sowie der Verbrauch unter Maximallast gestiegen sind. So kann auch die USB-Stromgrenze von 500 mA nicht immer eingehalten werden. Der Preis liegt bei 17 Pfund bzw. 20 Euro. 

Teilweise werden auch schon **Raspberry Pi Zero 2 WH** bzw **WHC** (Farbcodiert Stiftleiste) angeboten, bei denen die Steckerleiste breits angelötet wurde. Diese sind aber keine offiziellen Produkte.


## Bestellung

Ich persönlich bestellte früher gerne bei [PiHut](https://thepihut.com), wenn ich direkt in England bestellte. Bezahlen könnte man per Kreditkarte in Pfund. Dabei fallen bei VISA aufgrund der Fremdwährung zusätzlich 1,5 Prozent Bearbeitungskosten an. Die Versandkosten waren von allen englischen Shops am niedrigsten bei ca. 4 Pfund für kleine Pakete. Durch den Brexit und der damit verbundenen zusätzlichen Versteuerung bei der Einführ, ist diese Option aber eher uninteressant geworden.  
Früher habe ich auch gerne bei [KIWI Electronics](https://www.kiwi-electronics.nl/?lang=de) in Holland bestellt. Dort konnte man von Anfang an den Raspberry Pi Zero V1.3 und W zusammen bestellen und das bei sehr geringen Versandkosten. Zwischenzeitlich lieferten sie nur noch per Paketdienst nach Österreich, wodurch die Versandkosten viel zu hoch ware. Mittlerweils gibt es aber wieder die Post Option, bei der man für kleine Pakete ca. 7 bzw. 12 Euro zahlt. Die alten Raspberry Pi Zeros W/WH sind noch im Programm aber zu unatraktiven Preisen.  
In Österreich gibt es den Shop [semaf electronics](https://electronics.semaf.at). Die Preise sind zumeist geringfügig höher, manchmal aber auch niedriger als anderswo. Hier ist der **Raspberry Pi Zero WH** bereits aus dem Sortiment verschunden und dafür wird der **Raspberry Pi Zero 2 W** für 20 Euro gelistet. Der Versand bis 3 kg kostet 6,5 Euro.  
Aktuell bestelle ich nun gerne bei [Berrybase AT](https://www.berrybase.at/), früher bei [Berrybase DE](https://www.berrybase.de/). Hier bekommt man den [Raspberry Pi Zero 2 W](https://www.berrybase.at/raspberry-pi-zero-2-w) für etwas mehr als 20 Euro.  Die Versandkosten betragen 5,95 Euro von Österreich und 9,9 Euro von Deutschland aus.  
 
Benötigt man mehrere Raspberry Pi Zeros für z.B. einen Workshop, so landet man zwangsläuft bei der WH Version. Man muss auch bedenken, dass das manuelle Einlöten der Steckerleiste nicht gerade wenig Arbeit ist. Ganz zu schweigen vom aufwendigen Bestellprozess und der geringeren Preisreduktion wegen der Versandkosten.  
Im Übrigen habe ich auch bei der Raspberry Pi Foundation nachgefragt, ob es möglich ist für einen Raspberry Pi Jam mehrere Raspberry Pi Zero V1.3 zu bestellen.
Dies wurde mir nicht ermöglicht, da es so einen Support nur für Jams im Vereinigtem Königreich (UK) gibt.

Der Preis des **Raspberry Pi Zero 2 W** liegt nur geringfügig über dem **Raspberry Pi Zero WH** und ist nun endlich verfügbar. Daher ist der  **Raspberry Pi Zero 2 W** eine klare Kaufempfehlung. So lange musste man mit den Einschränkungen von ARM11 bzw. der ARMv6-Architektur auskommen, dass kann man nun getrost hinter sich lassen und vier Kerne und 64-Bit unterstützung genießen. Nur der noch magere 512 MB Speicher bleibt als Kritikpunkt.  
Ein Problem gibt es nun aber doch noch, **Raspberry Pi Zero 2 WH** werden nur teilweise angeboten und wenn mit einem ordenlichen Aufpreis von 50%, also ca. 30 Euro (semaf.at). Da lohnt es sich vielleicht doch den Lötkolben selbst zu "schwingen".