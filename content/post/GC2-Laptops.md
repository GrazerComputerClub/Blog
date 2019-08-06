+++
showonlyimage = false
draft = false
image = "img/GC2-Laptop.jpg"
date = "2019-08-04"
title = "GC2 Laptop CPU upgrade"
writer = "Martin Strohmayer"
categories = ["GC2"]
keywords = ["Laptop", "GC2"]
weight = 1
+++

Für die Raspberry Pi Jams haben wir uns uralte Dell Laptops besorgt. Teilweise könnten diese Laptops mit besseren Prozessoren ausgerüstet werden. Ein Vergleich der Prozessorleistung hilft die Leistungsfähigkeit einzuordnen.
<!--more-->

## Beschreibung ##

Um möglichst vielen TeilnehmerInnen die Möglichkeit zu geben an unseren Raspberry Pi Jam (Raspjamming) teilnehmen zu können wollten wir ein System zum Ausleihen anbieten.  
Möglich wären Tabletts, alte Laptops bzw. Netbooks oder Raspberry Laptops (Pi-Top) gewesen. Pi-Top hört sich gut an, ist aber weit außerhalb der Preisgrenze. Günstige Amazon Tabletts erschienen zuerst als günstigste Wahl. Allerdings mit dem Nachteil nicht aller Anwendungsfälle optimal abdecken zu können.  
Netbooks wären besser gewesen, diese hätten wir allerdings einzel gebraucht erwerben müssen. Das wäre wohl recht aufwendig gewesen. Die CPU-Leistung und Bildschirmauflösung (1024x600) wären nicht ganz optimal aber brauchbar.  
Dann hat sich allerdings ergeben, dass wir mehrere sehr alte Dell Laptops (ca. 2005) gebraucht kaufen konnten. Diese sind bei Firmen oft im Einsatz gewesen und dementsprechend auch robust gebaut. Die Laptop sind aus der Laptitude Serie D120, D131L, D531 usw..  

## Dell Laptitude ##

Leider sind bei mehreren Laptops nur Intel Pentium M Prozessoren verbaut. Diese sind zwar wesentlich schneller als Netbook Prozessoren (Intel Atom) aber sie besitzen ebenso nur einen einzigen 32-Bit Prozessorkern. Auch die AMD Sempron Prozessoren haben nur einen Kern aber unterstützen immerhin die 64-Bit Architektur.  
Die neuere Modell haben bereits einen Intel Core2 Duo Prozesser und damit durchaus ausreichend Performance. Es werden fast ausschließlich SO-DIMMs DDR2-SDRAM verwendet. Dieser ist leicht und günstig zu bekommen, sodass wir überall mindestens 1,5 GB RAM einbauen konnten. Teilweise besitzen die Modelle auch integrierte SD-Karten Lesegeräte, für die anderen können USB-Adapter bereitgestellt werden.
 
## Betriebssystem ##

Als Betriebssystem wurde eine Distribution gesucht, das auf alten PCs gut läuft und somit wenig Ressourcen benötigt. Es sollte aber auch eine gut gewartete bekannte Distribution sein. Darum fiele die ganz spezifischen Distributionen (SparkyLinux) weg. 
Zum Schluss verglichen wir Lubuntu und Mint XFCE. 

[![Lubuntu vs. Mint XFCE Boot](http://img.youtube.com/vi/zgWYeZaCS8c/0.jpg)](https://www.youtube.com/watch?v=zgWYeZaCS8c)

Beim Booten waren die Systeme ziemlich gleich schnell aber was Fehlermeldungen und Hardwareuntertütztung anging, war Mint XFCE eindeutig das bessere System. Es werden die Architektur i386 und amd64 angeboten und damit auch die alten Intel Pentium M Prozessoren unterstützt.
Wir entschlossen uns ausschließlich i386 zu verwenden um ein einheitliches System zu haben. 

## CPU Umbau ##

Nun stellte sich die Frage ob man die Laptops sinnvoll und günstig mit besseren CPUs ausrüsten kann.  
Bei den [Intel Pentium M](https://de.wikipedia.org/wiki/Intel_Pentium_M) Prozessoren könnten leider keine neueren Prozessortypen eingesetzt werden. Nur innerhalb der Serie kann auf höhergetaktete Modelle gewechselt werden. Zumeist waren 730 (1,6 GHz) oder 740 (1,73 GHz) Prozessoren verbaut. Das schnellste Modell ist der 780 mit 2,26 GHz, wobei dieser sehr teuer ist. Der zweitschnellste ist der 770 mit 2,13 GHz, er kostet gebraucht ca. 6 Euro. Trotz 30 % Mehrleistung wird die selbe TDP von 27 Watt angeben. 

Bei den Modellen mit [AMD Mobile Sempron](https://de.wikipedia.org/wiki/AMD_Mobile_Sempron) Prozessor mit S1-Sockel, kann auf die Zweikernprozessoren [AMD Turion 64 X2](https://de.wikipedia.org/wiki/AMD_Turion_64_X2) aufgerüstet werden. Der Laptop wurde bereits damals optional mit dem Prozessor TL-56 (1,8 GHz) angeboten. Die TDP liegt bei dem Modell je nach Revision bei 31 oder 33 Watt.   
Beim Upgrade haben wir uns für das Modell TL-58 (1,9 GHz) entschieden, da es sehr günstig mit nur 4 Euro zu bekommen ist und die TDP bei nur 31 Watt liegt. Der schnellste Prozessor der Serie wäre der TL-68 (2,4 GHz) mit einer TDP von 35 Watt. Ob eine Aufrüstung auf einen der neueren [AMD Turion X2 (Ultra)](https://de.wikipedia.org/wiki/AMD_Turion_X2)(z. B. RM-70 oder ZM-80) möglich wäre ist nicht bekannt und wurde nicht getestet.  

Die Durchführung des Umbaus der CPU, lief ohne Probleme. Es zweigte sich auch, dass die CPU-Kühlkörper und Lüfter dringend einer Reinigung bedurften. 

![CPU Umbau](../../img/CPU-upgrade.jpg)
![CPU Kühler](../../img/CPU-cooler-dirt.jpg)

  
## CPU Performance ##

Der Wechsel von Einkern- auf Zweikern-Prozessor bringt natürlich einen deutlichen Leistungsschub, die Singlecore-Leistung profitiert aber kaum vom Wechsel.
Wird innerhalb der Serie aufgerüstet steigt die Leistung linear mit der Taktrate.  
 
Als Vergleich wurde mit dem alten [nbench](https://www.math.utah.edu/~mayer/linux/bmark.html) Benchmark Programm alle CPUs vermessen und in einem Diagramm dargestellt. Als Referenz wurde in Grau ein Intel Atom N280 Prozessor und ein aktuellerer i7-4600U Prozessor (amd64 Achitektur) hinzugefügt. Auch die Performancewerte der Raspberry Pi Zero und 3+ sind im Diagramm (armhf Achitektur). Die hellrot und hellgrünen Prozessoren sind Einkern-Prozessoren.

![nBench Single Core CPU Leistung](../../img/Single-Core_Performance_GC2-Laptop_CPU.png)
 

 



