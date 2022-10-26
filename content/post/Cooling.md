+++
showonlyimage = false
draft = false
image = "img/fan.png"
date = "2020-09-14"
title = "Raspberry Pi CPU Kühlung"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "GC2"]
keywords = ["Lüfter", "Aktive Kühlung", "Kühlkörper", "CPU", "SoC", "gpio-fan"]
weight = 1
+++

Raspberry Pi Zero, Pi 1 und Pi 2 kommen noch gut ohne Kühlkörper und Lüfter aus. Aber wie sieht es bei den anderen Modellen aus? Vorweg ab der Raspberry Pi 3 ist eine aktive Kühlung bei leistungsintensive Anwendungen pflicht. Die bedarfsabhängige Lüftersteuerung kann sehr einfach aktiviert werden. 
<!--more-->

## Beschreibung ##

Wann eine Kühlung des SoC bzw. des Prozessor der Raspberry Pi nötig ist hängt von vielen Faktoren ab. Die Raspberry Pi Type, Umgebungstemperatur und das Gehäuse sind die wichtigsten. Um genau fest zu stellen unter welchen Bedingungen eine Kühlung notwendig ist, wurde mit dem GC2 3D-Druck-Gehäuse mehrere Leistungstest durchgeführt. Dazu wurde die Raspberry Pi 3 benutzt, sie besitzt keine Heatspreader. Zum Aufzeichnen der ARM Frequenz und der Prozessor-Temperatur wurde das Python Programm [bcmstat](https://github.com/MilhouseVH/bcmstat) verwendet. Bei GC2 Raspjamming OS ist das Programm bereits vorinstalliert. Die CPU-Last wurde mit dem Programm "stress" erzeugt.  
Beim Testl wurde folgendes Shell-Script verwendet

```bash
bcmstat.sh > rpi_$1.txt &
PID=$!
sleep 10
stress --cpu 1 --timeout 420s
sleep 180
stress --cpu 2 --timeout 420s
sleep 180
stress --cpu 3 --timeout 420s
sleep 180
stress --cpu 4 --timeout 420s
sleep 180
echo kill $PID
kill -KILL $PID
echo finished!
```

Der Test wurde bei einer typischen Umgebungstemperatur von 24 °C durchgeführt. Das verwendetet [Gehäuse](https://www.thingiverse.com/thing:559858) kann man sich mit einem 3D Drucker selbst herstellen.

## Analyse Temperaturen

![Raspberry Pi 3 Temperaturen](../../img/RPI3B_cooling.png)

Es zeigte sich, dass die Raspberry Pi 3 an ihre Temperaturgrenze stößt spätestens wenn alle 4 Kerne ausgelastet sind. dann wird vom System automatisch die Taktrate der CPU reduziert um eine Überhitzung von mehr als 82 °C zu vermeiden.  
Auch wenn man einen Kühlkörper auf den SoC befestigt, wird damit der Temperatur nur geringfügig reduziert. Erst wenn man den Kühlkörper mit einem langsam drehenden Lüfter anbläst, wird die Temperatur massiv reduziert und die volle Taktrate steht zur Verfügung.
 
![Raspberry Pi 3 Lüfterkühlleistung](../../img/RPI3B_cooling_fan_power.png)

Sieht man sich die Kühlleistung des Lüfters genauer an, so erreicht man eine Reduzierung um etwas weniger als 20 °C. Dabei war der Lüfter direkt an die 5 V Versorgung gesteckt worden und lief somit immer. Bei dem 12 V Typ war dann aber nicht gesichert, dass er bei 5 V immer anläuft. Hier sollte man eher einen 5 V Typ einsetzen.  

## Lüftersteuerung

Da man nun weiß, dass eine aktive Kühlung notwendig und sinnvoll ist, stellt sich nun die Frage, benötigt man den Lüfter immer bzw. muss der Lüfter ständig laufen?
Man könnte den Lüfter ja nur aktivieren wenn er wirklich gebraucht wird also wenn die Prozessortemperatur zu hoch ist. Tatsächlich ist so eine Funktion bereits im Kernel verfügbar. Der Devicetree gpio-fan ist genau für diese Funktion gemacht worden. 

```
Name:   gpio-fan
Info:   Configure a GPIO pin to control a cooling fan.
Load:   dtoverlay=gpio-fan,<param>=<val>
Params: gpiopin                 GPIO used to control the fan (default 12)
        temp                    Temperature at which the fan switches on, in
                                millicelcius (default 55000)
``` 

Als Parameter kann man den GPIO und die Einschalttemperatur angeben. Die Hysterese ist leider fix mit 10 °C hinterlegt.
In der Standard-Konfiguration wird der Lüfter also mit GPIO 12, ab 55 °C aktiviert und bei 45 °C deaktiviert. 

## Schaltung ##

Der GPIO darf natürlich nicht direkt an den Lüfter geschlossen werden. Die Stromaufnahme eines Lüfters liegt bei ca. 80-150 mA und damit weit über der Belastungsgrenze. Man muss also eine Transistor- oder FET-Schaltung als Schalter für die 5 V Versorgung verwenden. 

![Raspberry Pi Schaltung Lüftersteuerung](../../img/gpio-fan_5v_Steckplatine.png)

Bei der Transistorschaltung wird der leistungsfähige BC337 Typ verwendet. Er ist ein NPN-Transistor mit 800 mA Maximalstrom und mehr als 600 mW möglicher Verlustleistung. Als Basis-Vorwiderstand wird 4,7 KOhm verwendet, um den Ausgang möglichst wenig zu belasten.  

Soll der Lüfter besonders leise sein, empfiehlt es sich ihn mit nur ca. 3,3 V zu betreiben. Dazu kann man entweder einen Festspannungsregler (LM 1117 MPX-3.3) oder auch einfach 2 Dioden (1N4001) vorschalten.

![Raspberry Pi Schaltung Lüftersteuerung mit Festspannungsregler](../../img/gpio-fan_ldo_Steckplatine.png)
![Raspberry Pi Schaltung Lüftersteuerung mit Dioden](../../img/gpio-fan_diode_Steckplatine.png)


## Aktivierung Lüftersteuerung


In die Datei config.txt muss lediglich der Devicetree geladen und parametriert werden. In diesem Fall wird GPIO 21 verwendet. Die Aktivierung des Lüfters erfolgt bei 55 °C.

```
dtoverlay=gpio-fan,gpiopin=21
```

55 °C sind relativ wenig, wenn man bedenkt, dass diese Temperatur bereits mit der Belastung von einem Kern erreicht wird. Sinnvoller wäre es wohl den Lüfter erst bei einer höheren Temperatur z.B. bei 70 °C zu aktivieren. 

```
dtoverlay=gpio-fan,gpiopin=21,temp=70000
```

Wie man aber an der Kühlleistung des Lüfters sieht, wird die Prozessortemperatur um fast 20 °C verringert. Wenn die Hysterese aber nur 10 °C beträgt, bedeutet das, der Lüfter wird bei hoher Belastung immer wieder an- und ausgeschaltet. Die Temperatur schwankt dann immer zwischen 60 und 70 °C.  
Eine Erhöhung der Hysterese auf 20 °C würde den Lüfter im Bedarfsfall weniger oft aktivieren und dafür länger laufen lassen. Um die Hysterese zu verändern muss aber die Overlay Datei angepasst werden. Dazu muss sie in eine lesbare dts-Textdatei umgewandelt werden. Dann können die entsprechenden Parameter "hysteresis" und "temperature" (Hexadezimal-Werte) angepasst werden. Dann wird wieder eine neue binäre dtbo-Datei erzeugt.



```
cd /boot/overlays
sudo dtc -O dts -I dtb gpio-fan.dtbo -o gpio-fan.dts
```

```
cat gpio-fan.dts | egrep "temper|hyster"
  temperature = <0xd6d8>;
  hysteresis = <0x2710>;
```

Mit dem Konsolen Programm bc können die ermittelten Hexadezimal- und Dezimalwerte umrechnen.

```
sudo apt-get install bc
```

```
echo "ibase=16;D6D8" | bc
55000
echo "ibase=16;2710" | bc
10000

echo "obase=16;65000" | bc
FDE8
echo "obase=16;20000" | bc
4E20
```

Nun überprüfen wir ob man die Zahlen sicher ersetzen bzw. das sie kann.
```
cat gpio-fan.dts | egrep "d6d8|2710"
  temperature = <0xd6d8>;
  hysteresis = <0x2710>;
```

Nun ewiur:
```
sudo cp gpio-fan.dts gpio-fanH20.dts
sudo sed -i 's/d6d8/fde8/g' gpio-fanH20.dts
sudo sed -i 's/2710/4e20/g' gpio-fanH20.dts
sudo dtc -O dtb -I dts gpio-fanH20.dts -o gpio-fanH20.dtbo
```

Damit wurde ein neuer Devicetree mit dem Namen gpio-fanH20 erzeugt. In der Standard-Konfiguration wird der Lüfter also mit GPIO 12, ab 65 °C aktiviert und bei 20 °C weniger, also 45 °C deaktiviert.  

In der config.txt Datei kann der neue Devicetree geladen und gegebenenfalls parametriert werden.

```
dtoverlay=gpio-fanH20,gpiopin=21,temp=70000
```  


![Raspberry Pi 3 Temperature mit Lüftersteuerung](../../img/RPI3B_cooling_fan.png)


