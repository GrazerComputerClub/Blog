﻿+++
showonlyimage = false
draft = false
image = "img/zram.jpg"
date = "2023-02-07"
title = "Die Lebensdauer der SD-Karte verlängern mit ZRAM"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["ZRAM", "SWAP", "Auslagerungsdatei", "SD-Karte"]
weight = 1
Version = "Bullseye K5 & K6"
+++

Immer wieder kommt es zu Problemen mit der SD-Karte beim Raspberry Pi. Mit ZRAM wird im Arbeitsspeicher ein komprimierter Swap-Speicher angelegt. Dadurch kann die SD-Karte entlasten werden und hält dann hoffentlich länger. 
<!--more-->

## Beschreibung ##

Raspbian ist so konfiguriert das eine 100 MB Auslagerungsdatei auf der SD-Karte angelegt und benutzt wird. Swapping auf der SD-Karte ist langsam und führt zu einer Belastung der SD-Karte mit Schreiboperationen, die die Lebensdauer verringern. ZRAM legt im Arbeitsspeicher eine komprimierte Partition an, die dann primär als Swap-Bereich, also zum Auslagern von Speicherbereichen, benutzt wird. So wird die SD-Karte entlasten, Schreiboperationen eingespart und die Lebensdauer der Karte verlängert. 

## Installation ##

```
sudo apt install zram-tools
```

In der Datei "/etc/default/zramswap" erfolgt die Parametrierung des Dienstes. Hier kann die Größe der komprimieren Auslagerungspartition in Prozent (PERCENTAGE) oder absolut (ALLOCATION) in MB angegeben werden. 

```
# Compression algorithm selection
# speed: lz4 > zstd > lzo
# compression: zstd > lzo > lz4
# This is not inclusive of all that is available in latest kernels
# See /sys/block/zram0/comp_algorithm (when zram module is loaded) to see
# what is currently set and available for your kernel[1]
# [1]  https://github.com/torvalds/linux/blob/master/Documentation/blockdev/zram.txt#L86
ALGO=lz4

# Specifies the amount of RAM that should be used for zram
# based on a percentage the total amount of available memory
# This takes precedence and overrides SIZE below
#PERCENT=50

# Specifies a static amount of RAM that should be used for
# the ZRAM devices, this is in MiB
SIZE=48

# Specifies the priority for the swap devices, see swapon(2)
# for more details. Higher number = higher priority
# This should probably be higher than hdd/ssd swaps.
PRIORITY=100
```
Nachdem Änderungen vorgenommen wurden, muss der Dienst "zramswap" neu gestartet werden. 

```
sudo service zramswap restart
```

Mit dem Befehl ``swapon -s`` können die aktiven Auslagerungsspeicher aufgelistet werden. 
Es stehen dann 48 MB ZRAM Speicher und 100 MB Auslagerungsdatei zur Verfügung. 

```
Filename         Type            Size    Used    Priority
/var/swap        file            102396  0       -2
/dev/zram0       partition       49148   0       100
```

Mit dem Befehl ``zramctl`` können Informationen zum ZRAM ausgegeben werden.
```
NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
/dev/zram0 lz4        48M   4K   73B    4K       1 [SWAP]
```

Aktivieren und deaktivieren kann man den ZRAM Swap-Speicher über den Dienst "zramswap".
```
sudo service zramswap stop
free -h
```
```
              total        used        free      shared  buff/cache   available
Mem:          446Mi        53Mi       181Mi       6,0Mi       212Mi       335Mi
Swap:          99Mi          0B        99Mi
```

```
service zramswap start
free -h
```
```
              total        used        free      shared  buff/cache   available
Mem:          446Mi        54Mi       180Mi       6,0Mi       212Mi       334Mi
Swap:         147Mi          0B       147Mi
```

## Vergleichsmessung 

Zum Vergleich der Performance wurde auf einem Raspberry Pi 3 A+ unser Raspbian Image erzeugt. Die Raspberry Pi A hat nur 512 MB RAM, von dem nach dem Start nur 446 MB zur Verfügung stehen. Bei der Erzeugung wird ein wenig vom Swap-Speicher verwendet. Diese Aktion wurde einmal mit aktivem ZRAM und einmal nur mit der Auslagerungsdatei durchgeführt. 

```
              total        used        free      shared  buff/cache   available
Mem:          446Mi        50Mi       301Mi       8,0Mi        95Mi       336Mi
Swap:         147Mi          0B       147Mi
```

### ZRAM Swap-Bereich (48 MB) & Auslagerungsdatei (100 MB)

**Dauer:**  
real    54m17,618s  
user    29m49,723s  
sys     7m1,729s  

**Swap-Speicher:**
```
Filename				Type		Size	Used	Priority
/dev/zram0                             	partition	49148	22296	100
/var/swap                              	file    	102396	388	-2
```


### Auslagerungsdatei (100 MB)
<!--
```
              total        used        free      shared  buff/cache   available
Mem:          446Mi        50Mi       239Mi       6,0Mi       156Mi       335Mi
Swap:          99Mi          0B        99Mi
```
-->
**Dauer:**  
real    58m12,032s  
user    29m31,706s  
sys     7m0,105s  

**Swap-Speicher:**
```
Filename                                Type            Size    Used    Priority
/var/swap                               file            102396  21476   -2
```

### Auswertung

Bei Erzeugungsprozess werden ca. 20 MB von dem Swap-Speicher benutzt. Mit aktiven ZRAM wird die Auslagerungsdatei auf der SD-Karte kaum verwendet. Auch die Ausführungsdauer hat sich mit ZRAM verringert. Die Verwendung hat also einen doppelt positiven Effekt.


## 100 MB Swap-Datei entfernen ##


Um die  Swap-Datei auf der SD-Karte zu deaktivieren, muss man in der Konfigurationsdatei "/etc/dphys-swapfile" den Wert CONF_SWAPSIZE auf 0 einsetzen.

```
CONF_SWAPSIZE=0
```

```bash
sudo service dphys-swapfile restart
```

Eventuell kann man danach noch die Swap-Datei löschen mit ``sudo rm /var/swap``.
