+++
showonlyimage = false
draft = false
image = "img/GC2-Laptop.jpg"
date = "2019-08-04"
title = "Dell Laptop upgrade"
writer = "Martin Strohmayer"
categories = ["GC2"]
keywords = ["Laptop", "GC2", "CPU", "Dell", "Latitude","120L", "131L", "D520", "D530", "D531", "BIOS", "nbench"]
weight = 1
+++

Für die Raspberry Pi Jams haben wir uns uralte Dell Laptops besorgt. Teilweise könnten diese Laptops mit besseren Prozessoren ausgerüstet werden. Ein Vergleich der Prozessorleistung hilft die Leistungsfähigkeit einzuordnen.
<!--more-->

## Beschreibung ##

Um möglichst vielen TeilnehmerInnen die Möglichkeit zu geben an unseren Raspberry Pi Jam (Raspjamming) teilnehmen zu können wollten wir ein System zum Ausleihen anbieten.  
Möglich wären Tabletts, alte Laptops bzw. Netbooks oder Raspberry Laptops (Pi-Top) gewesen. Pi-Top hört sich gut an, ist aber weit außerhalb der Preisgrenze. Günstige Amazon Tabletts erschienen zuerst als günstigste Wahl. Allerdings mit dem Nachteil nicht aller Anwendungsfälle optimal abdecken zu können.  
Netbooks wären besser gewesen, diese hätten wir allerdings einzel gebraucht erwerben müssen. Das wäre wohl recht aufwendig gewesen. Die CPU-Leistung und Bildschirmauflösung (1024x600) wären nicht ganz optimal aber brauchbar.  
Dann hat sich allerdings ergeben, dass wir mehrere sehr alte Dell Laptops (ca. 2005-2008) gebraucht kaufen konnten. Diese sind bei Firmen oft im Einsatz gewesen und dementsprechend auch robust gebaut. Die Laptops sind aus der Latitude Serie 120L, 131L, D510, D520, D530, D531.

## Dell Laptitude ##

Leider sind bei mehreren Laptops nur Intel Pentium M Prozessoren verbaut. Diese sind zwar wesentlich schneller als Netbook Prozessoren (Intel Atom) aber sie besitzen ebenso nur einen einzigen 32-Bit Prozessorkern.  Die Core Duo Prozessoren haben zwar zwei Kerne, unterstützen aber auch nur die 32-Bit Architektur. Die AMD Sempron Prozessoren haben nur einen Kern aber unterstützen immerhin die 64-Bit Architektur. Die neuere Modell haben bereits einen Intel Core 2 Duo Prozesser und damit einen Zweikernprozessor mit gesteigerter Leistung und 64-Bit unterstützung.  
Es werden fast ausschließlich SO-DIMMs DDR2-SDRAM bei den Laptops verwendet. Dieser ist leicht und günstig zu bekommen, sodass wir überall mindestens 1,5 GB RAM einbauen konnten. Teilweise besitzen die Modelle auch integrierte SD-Karten Lesegeräte, für die anderen können USB-Adapter bereitgestellt werden. Die Displays sind im 4:3 Format und haben die Auflösung 1280x800 oder 1400x1050, nur der D510 hat eine Auflösung von 1024x768. Als Festplatte kommen IDE-Platten oder SATA-Platten mit min. 40 GB zu Einsatz.
Leider fehlten viel Netzteile, allerdings können die standardisierten Modelle PA-16 und PA-10 bzw. PA-12 auch heute noch leicht gebraucht und neu erworben werden.

## Betriebssystem ##

Als Betriebssystem wurde eine Distribution gesucht, das auf alten PCs gut läuft und somit wenig Ressourcen benötigt. Es sollte aber auch eine gut gewartete bekannte Distribution sein. Darum fielen die ganz spezifischen Distributionen (SparkyLinux) weg. 
Zum Schluss verglichen wir Lubuntu und Mint XFCE. 

[![Lubuntu vs. Mint XFCE Boot](http://img.youtube.com/vi/zgWYeZaCS8c/0.jpg)](https://www.youtube.com/watch?v=zgWYeZaCS8c)

Beim Booten waren die Systeme ziemlich gleich schnell aber was Fehlermeldungen und Hardwareuntertütztung anging, war Mint XFCE eindeutig das bessere System. Es werden die Architektur 32-Bit (i386) und 64-bit (x86_64) angeboten und damit auch die alten Intel Pentium M und Core Duo Prozessoren unterstützt, die noch keine 64-Bit Erweiterung besitzen. Wir entschlossen uns ausschließlich 32-Bit zu verwenden um ein einheitliches System zu haben. 

## Perfomance 32- vs 64-Bit Architektur

### AMD Turion

Ein Performancevergleich von alten Systemen mit dem Titel [Ubuntu: 32-bit v. 64-bit Performance](https://www.phoronix.com/scan.php?page=article&item=616) von 2006 ist bei Phoronix verfügbar. Hier zeigt sich, dass sich der Leistungzuwachs bei 64-Bit kaum bemerkbar macht.  
Bei einem eigenen Testlauf mit dem AMD Sempron und Turion X2 Prozessor ist bei 7-zip (siehe Bild) und Firefox Java Script Benchmark [Octane](https://chromium.github.io/octane/) kaum eine Verbesserung festellbar (ca. 4 %). Allerdings zeigt das nbench Testprogramm eine gesteigerte Leistung von ca. 16 % (siehe Bild). 

![AMD Sempron und Turion nbench Index leistung](../../img/Turion_32vs64_nbench.png) 
![AMD Sempron und Turion 7-zip entpacken Leistung](../../img/Turion_32vs64_7zip.png) 

### Intel Core 2 Duo

Bei den neueren Intel Core 2 Duo Prozessoren ist eine weitere Bewertung nötig. Ein Performancevergleich von 2009 mit dem Titel [Ubuntu 32-bit, 32-bit PAE, 64-bit Kernel Benchmarks](https://www.phoronix.com/scan.php?page=article&item=ubuntu_32_pae) ist bei Phoronix verfügbar. Hier werden wesentlich Performancevorteile bei 64-Bit festgestellt.  
Die Vergleichsmessung unsererseits kann diese Messungen nicht bestätigen. Mit dem Core 2 Duo T7200 Prozessor ist bei 7-zip (siehe Bild) und Firefox Java Script Benchmark [Octane](https://chromium.github.io/octane/) kaum eine Verbesserung festellbar (ca. 4 %). Allerdings zeigt das nbench Testprogramm eine gesteigerte Leistung von ca. 17 % (siehe Bild). 

![Core 2 Duo T7200 nbench Index leistung](../../img/C2D_32vs64_nbench.png) 
![Core 2 Duo T7200 7-zip entpacken Leistung](../../img/C2D_32vs64_7zip.png) 

Die Entscheidung wegen den Pentium M und Core Duo Prozessoren auf ausschließlich 32-Bit zu setzen, wir noch evaluiert und ist nicht final fixiert. Die Performanceeinbußen halten sich aber in Grenzen, sodass kein akuter Handlungsbedarf besteht. 


## CPU Umbau ##

Zuerst stellte sich die Frage ob man die Laptops sinnvoll und günstig mit besseren CPUs ausrüsten kann. Dazu muss man den Hersteller, Sockel und den Chipsatz analysieren.


### CPU Typ Intel (Sockel 479 / Sockel M)

Bei den [Intel Pentium M](https://de.wikipedia.org/wiki/Intel_Pentium_M) Prozessoren können leider keine neueren Prozessortypen eingesetzt werden. Nur innerhalb der Serie kann auf höher getaktete Modelle gewechselt werden. Im Latitide D510 ist ein 730 (1,6 GHz) und beim Latitide 120L ein 740 (1,73 GHz) Prozessoren verbaut. Das schnellste Modell ist der 780 mit 2,26 GHz, wobei dieser sehr teuer ist. Der zweitschnellste ist der 770 mit 2,13 GHz, er kostet gebraucht ca. 6 Euro. Trotz 30 % Mehrleistung wird die selbe TDP von 27 Watt angeben. 

Bei den neuer Intel Prozessoren der [Core Duo](https://de.wikipedia.org/wiki/Intel_Core_Duo) und [Core 2 Duo](https://de.wikipedia.org/wiki/Intel_Core_2) Serie kommt es vorallen auf dem verwendeten Chipsatz an welche Prozessoren man einsetzen kann. Prinzipiell können Core Duo durch Core 2 Duo ersetzt werden, was viel Spielraum beim Upgrade ermöglicht. Die Core Duo Prozessoren können noch keine 64-Bit Erweiterung und haben fast die gleiche Single-Core Performance wie die Pentium M Prozessoren. Ein Core 2 Duo unterstützt die 64-Bit Architektur und hat eine gesteigerte Leistung bei gleichem Takt, er ist also die bessere Wahl.
Beim Latitide D520 wird ein 945 Chipsatz von Intel verwendet. Auf der Internet Seite [Intel 945GM Express chipset processor support](http://www.cpu-upgrade.com/mb-Intel_(chipsets)/945GM_Express.html) wird eine Tabelle mit möglichen Prozessoren angezeigt. Ob wirklich nur diese eingesetzt werden können, ist nicht sicher aber zumindest eine Anhaltspunkt. Wichtig ist, dass nur Prozessoren mit 667 MHz FSB eingesetzt werden können. Als Topmodell wird der T7600 mit 2,33 GHz Taktfrequenz und 4 MB Cache angeben. Dieser ist aber natürlich vergleichsweise teuer. Darum ist die günstigste Variante der T7200 mit 2,0 GHz Taktfrequenz. Es ist teilweise für nur etwas mehr als einem Euro erhältlich.  

Beim Latitide D530 wird ein 965 Chipsatz von Intel verwendet. Auf der Internet Seite [Intel GM965 Express chipset processor support](http://www.cpu-upgrade.com/mb-Intel_(chipsets)/GM965_Express.html) wird eine Tabelle mit möglichen Prozessoren angezeigt. Wichtig ist, dass nur Prozessoren mit 800 MHz FSB eingesetzt werden können. Als Topmodell, fern der Extreme Edition, wird der T9500 mit 2,6 GHz Taktfrequnz und 6 MB Cache angeben. Dieser ist aber wieder sehr teuer. Darum haben wir uns vorserst für den günstigen T8300 mit 2,4 GHz und 4 MB Cache entschieden. Hier mussten wir aber feststellen, dass selbst das neueste BIOS die T8- und T9-Serie gar nicht unterstützt. Damit muss man bei einen Prozessor aus der T7-Serie bleiben. Der schnellste wäre der T7800, er ist allerdings wieder sehr teuer. Die Modelle T7700 und T7500 wären kostengünstigere Alternativen. Wobei der bereits vorhanden T7250 eine recht ordenliche Leistung bietet und nicht unbedingt ausgetauscht werden muss.  

Insgesamt wurde zumindest eine um 20 % hohere Taktrate bei weniger als 4 Euro Kosten angestrebt. Beim Wechsel von Core Duo auf Core 2 Duo ist allerings aufgrund des besseren Single-Core Performance bereits eine Verbesserung vorhanden.  
Bei Latitide D530 wurde auf eine Prozessorwechsel verzichtet nachdem der T8300 nicht funktionierte. 

### CPU Typ AMD (Socket-1)

Bei den Modellen mit [AMD Mobile Sempron](https://de.wikipedia.org/wiki/AMD_Mobile_Sempron) Prozessor mit S1-Sockel, kann auf die Zweikernprozessoren [AMD Turion 64 X2](https://de.wikipedia.org/wiki/AMD_Turion_64_X2) aufgerüstet werden. Der Laptop D531 wurde bereits damals optional mit dem Prozessor TL-56 (1,8 GHz) angeboten. Die TDP liegt bei dem Modell je nach Revision bei 31 oder 33 Watt.  
Beim Upgrade haben wir uns für das Modell TL-58 (1,9 GHz) und TL-60 (2,0 GHz) entschieden, da sie sehr günstig mit nur 3-4 Euro zu bekommen sind und die TDP bei nur 31 Watt (G1/G2) liegt. Den TL-60 Prozessor gibt es in der Revision F2 (90 nm) mit 35 Watt und G1/G2 (60 nm) mit 31 Watt TDP. Beide Typen sind günstig zu bekommen, allerdings ist nicht sicher welche Variante man bekommt. Der schnellste Prozessor der Serie wäre der TL-68 (2,4 GHz, 60 nm) mit einer TDP von 35 Watt. Alle Modelle ab den TL-62 sind leider teuer, besonders das Topmodell.  
Eine Aufrüstung auf die neuere [AMD Turion X2 (Ultra)](https://de.wikipedia.org/wiki/AMD_Turion_X2)(z. B. RM-70 oder ZM-80) Generation ist leider nicht möglich. Sie benutzen den neueren S1-Sockel in der zweiten Generation (s1g2) der eine andere Pinbelegung benötigt. Dies wurde explizit verifiziert!


### BIOS update ##

Im Zuge des CPU Umbaus sollte man auch das BIOS des Laptops auf aktuellen Stand bringen. Hier war fast duchweges eine veraltete Version auf den Systemen zu finden. Beim Latitude D531 war sogar die erste Version A00 von 2007 installiert. Zum Download beim [Dell-Support](https://www.dell.com/support/home/at/de/atdhs1/) stehen die Versionen A10 von 2011 und A12 von 2013 zur Verfügung. Welche Änderungen das Update bringt, kann man aufgrunde der fehlenen Angabe nur erahnen. Bei Version A10 ist angegeben "Enhanced support for AMD Power Now" und bei A12 "Enhance System Security". Mehr Informationen inbesonders eine komplette Change History wird nicht bereitgestellt.  
Für den Aktualiserungsvorgang wurde ein FreeDOS USB-Bootstick erstellt. Leider hat der mit UNetbootin unter Linux erstellte USB-Stick nicht gebootet. Der mit Rufus unter Windows erzeugte, hat anstandslos gebootet. Hierzu musst man am Anfang die F12-Taste drücken, um ins Boot-Menü zu gelangen. Dann kann USB-Device als Bootmedium gewählt werden.  
Auf den USB-Stick wurden zuvor noch die aktuellsten BIOS Dateien von allen Systemen kopiert. Beim Latitude D531 heißt die BIOS Update Datei "D531_A12.exe". Diese kann unter DOS ausgeführt werden und damit wurde der Aktualiserungsvorgang ohne Rückfrage gestartet. Beim manchen Systemen wie D510 muss man noch eine beliebige Taste und die englische Y-Taste (also Z-Taste) drücken. Nach einer längeren Zeit zumeist ohne Rückmeldung, startet der Laptop automatisch neu mit dem aktualisieren BIOS. Der Ablauf war im Großen und Ganzen bei den unterschiedlichen Laptopserien gleich, nur die jeweilige BIOS-Datei hat einen eigenen Namen.


### Umbau

Die Durchführung des Umbaus der CPU beim Latitude D531, lief ohne Probleme. Es muss hierzu lediglich die Abdeckung oberhalb der Tastatur hochgehoben werden. Dann kann die Tastatur abgeschraubt und entfernt werden. Beim Latitude 131L musste das gesamte Gehäuse zerlegt werden, da sich die CPU unter einer Abdeckung befindet. Dann müssen die Antennenleitungen von WLAN-Modul abgesteckt werden. Danach kann der Kühlkörper abgeschraubt und herausgehoben werden. Es zeigte sich auch, dass die CPU-Kühlkörper und Lüfter dringend einer Reinigung bedurften. Am CPU-Sockel ist eine Schlitzschraube die um 90° bzw teilweise um 180° gedreht werden muss. Dann kann die CPU ausgetauscht werden und aller wieder zusammengebaut werden.  
 
[![Dell Latitude D531 CPU upgrade](http://img.youtube.com/vi/AnkonHJD6eA/0.jpg)](https://www.youtube.com/watch?v=AnkonHJD6eA)

  
### Performance 

Der Wechsel von AMD Sempron Einkern- auf Turion Zweikern-Prozessor bringt natürlich einen deutlichen Leistungsschub, die Singlecore-Leistung profitiert aber nur geringt vom Wechsel.  
Wird innerhalb der gleichen Serie aufgerüstet, steigt die Leistung linear mit der Taktrate. Beim Wechsel von Intel Core auf Intel Core 2 bringt der Wechsel ca. 17 % wie man beim Vergleich T2300 zu T5500 sehen kann.  Wechsel man von T2300 auf T7200 bringt das insgesamt sogar knapp 40 % mehr Leistung.
Als Vergleich wurde mit dem alten [nbench](https://www.math.utah.edu/~mayer/linux/bmark.html) Benchmark Programm alle CPUs vermessen und in einem Diagramm dargestellt. Als Referenz wurde in Grau ein Intel Atom N280 Prozessor und ein i5-M450 sowie ein aktuellerer i7-4600U Prozessor (amd64 Architektur) hinzugefügt. Auch die Performancewerte der Raspberry Pi Zero, 3+ und 4 sind als Vergleich im Diagramm (armhf Architektur) enthalten. Im Diagramm wurden Einkern-Prozessoren in helleren Farben dargestellt.

![nBench Single Core CPU Leistung](../../img/Single-Core_Performance_GC2-Laptop_CPU.png)


## RAM Aufrüstung ##

Die AMD- und Intel-Systeme unterstützen DDR2 SODIMM RAM bis 667 MHz. Es wurde bei allen Dual Core Systemen eine mind. 2 GB Speichergröße angestrebt. 
Dazu wurden mehrere 2 GB Module mit 800 MHz bestellt, die pro Modul ca. 3-4 Euro kosten. Eine geringere Frequenz bringt keine Kostenersparnis.
Alle System sind mit 2 Speicherslots ausgeführt, sodass zumeist 2,5 GB erreicht wurden. Teilweise werden Teile des Speichers für die Grafikkarte benutzt, diese Zuordnung wurde auf 128 MB begrenzt.  


## Display Reparatur ##

Bei einem D531 Latitude Laptop funktionierte die Hintergrundbeleuchtung des Displays nicht. Es war zu erkennen, dass die Anzeige funktionierte, aber eben extrem dunkel. Auf Verdacht wurde dann die Versorgungsplatine (Dell LCD Inverter Board LJ97-01015A) getauscht. Das entsprechende Modul konnte um ca. 7 Euro nachbestellt werden. Es wurde dann zwar nicht exakt die gleiche Platine geliefert (siehe Bild unten), dennoch hat nach dem Umbau das Display wieder funktioniert. 

![LCD Wechslrichter](../../img/LJ97-01015A.jpg)
