+++
showonlyimage = false
draft = false
image = "img/CPU.jpg"
date = "2019-09-15"
title = "SoC der Einplatinencomputer"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["CPU", "Cortex", "ARM11", "A72", "A7", "A53", "BCM2835", "BCM2836", "BCM2837", "A20", "H2+", "H3", "H5"]
weight = 1
+++

Eine interessante Kenngröße der vielen verschienen Einplatinencomputer-Varianten ist die Singlecore-Leistung der CPU. Eine Diagramm soll helfen die Prozessoren bzw. Produkte einordenen zu können ...
<!--more-->

## Beschreibung ##

Der Raspberry B+ und Zero setzen noch auf den SoC (System-on-a-Chip) BCM2835 von Broadcom. Dieser enthält einen alten ARM11 Prozessorkern. Dadurch sind die Messergebnisse vom Raspberry Pi B+ mit Turbo Einstellung identisch zum Raspberry Pi Zero. Der Raspberry Pi 2 verwendet den SoC BCM2836 von Broadcom. Darin enthalten sind vier ARM Cortex-A7 Prozessorkerne. Der Raspberry Pi 3 verwendet den SoC BCM2837 von Broadcom mit einer Taktrate von maximal 1200 MHz. Der Raspberry Pi 3+ verwendet eine verbesserte Version des selben SoC mit der Bezeinchnung BCM2837B0. Er wird mit einem Heatspreader ausgeliefert und die Taktrate beträgt nun maximal 1400 MHz. Im SoC enthalten sind vier ARM Cortex-A53 Prozessorkerne. Der Raspberry Pi 4 verwendet den SoC BCM2711B0 von Broadcom mit vier ARM Cortex A72 Prozessorkernen mit einer Taktrate von 1,5 GHz. Die CPU-Leistung ist dadruch enorm gestiegen und liegt beinahe doppelt so hoch als beim Raspberry Pi 3. Die Leistungsaufnahme des SoC ist unter Belastung auch gestiegen, weshalb der Einsatz eines CPU Lüfters empfohlen wird. Ein Kühlkörper wird dann nicht mehr benötigt den der SoC ist mit einem Heatspreader ausgestattet.  

Andere preisgünstge Einplatinencomputer wie der Banana Pi und Orange Pi setzen auf SoCs von Allwinner. Der SoC A20 enthät 2 ARM Cortex-A7 Prozessorkerne, H2+ und H3 enthalten wie wie beim Raspberry Pi 2, vier ARM Cortex-A7 Prozessorkerne. Je nach Modell werden Taktraten von 1,2 bis 1,4 GHz unterstützt.  
Neuere Orange Pi Einplatinencomputer setzt den Allwinner SoC H5 ein. Dieser hat wie der Raspberry Pi 3(+) vier ARM Cortex-A53 Prozessorkerne. Hier wird allerdings auch schon die 64-Bit ARM Architektur "aarch64" unterstützt.  
 
Für die Ermittlung der CPU-Singlecore-Leistung wurde das alte Testprogramm [nbench](https://www.math.utah.edu/~mayer/linux/bmark.html) verwendet. Auf der [Homepage](https://www.math.utah.edu/~mayer/linux/results2.html) des Projekts sind viele Messergebnisse von anderen Systemen als Referenz verfügbar.  
Zum Vergleich wurde ein Intel Atom N280 und auch ein Intel Pentium M Prozessor mit 1,6 GHz ins Diagramm übernommen. Um beim Raspberry Pi 4 einen vergleich zu haben, wurde auch noch ein 2 GHz Intel Core 2 Duo hinzugefügt. 

![Diagramm CPU-Performance SoC](../../img/CPU_Performance.png) 


## Systemausgaben ##

Hier sind Sytemausgaben des Device-tree Modells (/proc/device-tree/model), der CPU (/proc/cpuinfo) und des Kommandos "lscpu" bei verschiedenen Einplatinencomputer aufgelistet.

### Raspberry Pi ###

Bei den Raspberry Pi Einplatinencomputern liefert Hardware bei "/proc/cpuinfo" immer  "BCM2835" obwohl diese CPU nur bei Raspberry Pi 1 und Zero verwendet wird.

#### Raspberry Pi Model B Rev 1 
```
processor       : 0
model name      : ARMv6-compatible processor rev 7 (v6l)
BogoMIPS        : 697.95
Features        : half thumb fastmult vfp edsp java tls 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xb76
CPU revision    : 7

Hardware        : BCM2835
Revision        : 0002
Serial          : 0000000046b94602
```
```
Architecture:        armv6l
Byte Order:          Little Endian
CPU(s):              1
On-line CPU(s) list: 0
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           1
Vendor ID:           ARM
Model:               7
Model name:          ARM1176
Stepping:            r0p7
CPU max MHz:         700,0000
CPU min MHz:         700,0000
BogoMIPS:            697.95
Flags:               half thumb fastmult vfp edsp java tls
```

#### Raspberry Pi Zero Rev 1.3
```
processor       : 0
model name      : ARMv6-compatible processor rev 7 (v6l)
BogoMIPS        : 997.08
Features        : half thumb fastmult vfp edsp java tls 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xb76
CPU revision    : 7

Hardware        : BCM2835
Revision        : 900093
Serial          : 0000000076def51e
```
```
Architecture:        armv6l
Byte Order:          Little Endian
CPU(s):              1
On-line CPU(s) list: 0
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           1
Vendor ID:           ARM
Model:               7
Model name:          ARM1176
Stepping:            r0p7
CPU max MHz:         1000,0000
CPU min MHz:         700,0000
BogoMIPS:            697.95
Flags:               half thumb fastmult vfp edsp java tls
```

#### Raspberry Pi 3 Model B Rev 1.2
```
processor       : 0-3
model name      : ARMv7 Processor rev 4 (v7l)
BogoMIPS        : 76.80
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

Hardware        : BCM2835
Revision        : a02082
Serial          : 000000008d457b3d
```

#### Raspberry Pi 3 Model A Plus Rev 1.0
```
processor       : 0-3
model name      : ARMv7 Processor rev 4 (v7l)
BogoMIPS        : 38.40
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4

Hardware        : BCM2835
Revision        : 9020e0
Serial          : 000000003902dfdb
```
```
Architecture:        armv7l
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
Vendor ID:           ARM
Model:               4
Model name:          Cortex-A53
Stepping:            r0p4
CPU max MHz:         1400,0000
CPU min MHz:         600,0000
BogoMIPS:            38.40
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
```

#### Raspberry Pi 4 Model B Rev 1.1
```
processor	: 0-3
model name	: ARMv7 Processor rev 3 (v7l)
BogoMIPS	: 108.00
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd08
CPU revision	: 3

Hardware	: BCM2835
Revision	: c03111
Serial		: 100000002db21ca2
```

### Banana Pi ###

#### LeMaker Banana Pi
```
processor	: 0-1
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 27.78
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xc07
CPU revision	: 4

Hardware	: Allwinner sun7i (A20) Family
Revision	: 0000
Serial		: 16516793044069ae
```
```
Architecture:        armv7l
Byte Order:          Little Endian
CPU(s):              2
On-line CPU(s) list: 0,1
Thread(s) per core:  1
Core(s) per socket:  2
Socket(s):           1
Vendor ID:           ARM
Model:               4
Model name:          Cortex-A7
Stepping:            r0p4
CPU max MHz:         960.0000
CPU min MHz:         144.0000
BogoMIPS:            50.52
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
```

### Orange Pi ###

#### Xunlong Orange Pi Zero
```
processor       : 0-3
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 48.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5

Hardware        : Allwinner sun8i Family
Revision        : 0000
Serial          : 02e00038a3fdef67
```
```
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
Vendor ID:           ARM
Model:               5
Model name:          Cortex-A7
Stepping:            r0p5
CPU max MHz:         1008.0000
CPU min MHz:         120.0000
BogoMIPS:            48.00
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
```

#### Xunlong Orange Pi PC
```
processor       : 0-3
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 61.71
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5
Hardware        : Allwinner sun8i Family
Revision        : 0000
Serial          : 02e00071006abb9c
```
```
Architecture:        armv7l
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
Vendor ID:           ARM
Model:               5
Model name:          Cortex-A7
Stepping:            r0p5
CPU max MHz:         1368.0000
CPU min MHz:         120.0000
BogoMIPS:            22.85
Flags:               half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm
```

#### Xunlong Orange Pi PC 2
```
processor       : 0-3
Processor       : AArch64 Processor rev 4 (aarch64)
Hardware        : sun50iw1p1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 4
```
```
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3-
Thread(s) per core:  1
Core(s) per socket:  4
Socket(s):           1
NUMA node(s):        1
Vendor ID:           ARM
Model:               4
Model name:          Cortex-A53
Stepping:            r0p4
CPU max MHz:         1368.0000
CPU min MHz:         120.0000
BogoMIPS:            48.00
NUMA node0 CPU(s):   0-3
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
```

### CPU Parameter auslesen  ###

```
CORES=`cat /proc/cpuinfo | grep -e "^processor" | wc -l`
ARMvX=`cat /proc/cpuinfo | sed -n 's/.*ARMv\(.*\)-.*/\1/p'`
MODEL=`lscpu | grep "Model name" | cut -d ":" -f 2 | xargs`
```

