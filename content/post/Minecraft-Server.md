+++
showonlyimage = false
draft = false
image = "img/MinecraftServer.jpg"
date = "2020-12-05"
title = "Minecraft Server"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi", "Minecraft"]
keywords = ["Raspberry Pi", "Minecraft", "Server"]
weight = 1
+++

Minecraft kann zwar nicht auf einem Raspberry Pi gespielt werden, aber ein Minecraft Server kann mit einem Raspberry Pi 4 betrieben werden. Dank eines verfügbaren Bash-Script ist die Einrichtung keine Hexenwerk.
<!--more-->


## Grundsätzliches

Minecraft ist ein, besonders bei kleinen Kindern aber auch bei Erwachsenen beliebtes Computerspiel. Wenn mehrere Leute öfter gemeinsam Spielen wollen, so  macht es Sinn einen Minecraft Server zu betreiben. Diese Aufgabe kann insbesonders von einem Raspberry Pi 4 der mit ausreichend RAM (2 oder noch besser 4 GB) ausgestattet ist, erledigt werden. Von TheRemote gibt es ein Bash-Script das die Installation sehr vereinfacht. 


## Basis Installation und Einrichtung

Als Basis für den Server wird ein Raspberry Pi OS Lite 32-Bit verwendet.  
Folgende Schritte müssen initial durchgeführt werden:

* Raspberry Pi OS Lite 32-Bit herunterladen und auf eine schnelle MicroSD Karte schreiben
* In der Boot Partition die Datei ssh erzeugen
* Login mit Benutzer "pi" und Passwort "raspberry" (per SSH) bzw. "raspberrz" (lokal)
* Updates installieren: ``sudo apt-get update && sudo apt-get -y upgrade``
* Lokalisierungseinstellungen (Sprache, Zeitzone usw.) mit ``sudo rasp-config`` einstellen
 

## MicroSD Benchmark

Die Geschwindigkeit der MicroSD-Karte ist von entscheidender Bedeutung für den Minecraft Server. Mit einem Benchmark vom Autor, kann die Karte überprüft werden.  

```
sudo curl https://raw.githubusercontent.com/TheRemote/PiBenchmarks/master/Storage.sh | sudo bash 
```

```
     Category                  Test                      Result     
HDParm                    Disk Read                 28.48 MB/s               
HDParm                    Cached Disk Read          21.54 MB/s               
DD                        Disk Write                12.3 MB/s                
FIO                       4k random read            2380 IOPS (9523 KB/s)    
FIO                       4k random write           204 IOPS (818 KB/s)      
IOZone                    4k read                   7050 KB/s                
IOZone                    4k write                  1357 KB/s                
IOZone                    4k random read            6883 KB/s                
IOZone                    4k random write           999 KB/s                 

                          Score: 700                                         
```

Laut Autor wäre ein "Score" von 1000 wünschenswert. Unter 700 sollte er nicht sein, dann sollte man auf eine USB SSD ausweichen.
Die verwendete SanDisk Ultra microSDHC 8 GB Class 10 Karte liegt am unteren Grenzwert, reicht also gerade so.

## Minicraft Server Installation 

```
wget https://raw.githubusercontent.com/TheRemote/RaspberryPiMinecraft/master/SetupMinecraft.sh
chmod +x SetupMinecraft.sh
```
Bevor man die Installation startet, kann man noch vorgeben welche Version installiert werden soll. Dazu editiert man die "SetupMinecraft.sh" Datei und gibt in der 7 Zeile die Versionsnummer an. Aber Achtung die Version muss von Paper Minecraft unterstützt werden. Mit folgenden Befehl können die aktuell verfügbaren Versionen aufgelistet werden ``wget -qO- https://papermc.io/api/v1/paper``.

```
{"project":"paper","versions":["1.16.5","1.16.4","1.16.3","1.16.2","1.16.1","
```

In diesem Fall ist die Version 1.16.5 die neueste verfügbare Version, die wir im Setup-Script eintragen können.

```
# Minecraft server version
Version="1.16.5"
```

Dann kann das Setup gestartet werden.

```
./SetupMinecraft.sh
```
```
Java installed successfully
Getting total system memory...
Total memory: 3828 - Available Memory: 3587
Warning: You are running a 32 bit operating system which has a hard limit of 3 GB of memory per process
You must also leave behind some room for the Java VM process overhead.  It is not recommended to exceed 2700 and if you experience crashes you may need to reduce it further.
You can remove this limit by using a 64 bit Raspberry Pi Linux distribution (aarch64/arm64) like Ubuntu, Debian, etc.
Total memory: 3828 - Available Memory: 2700
Please enter the amount of memory you want to dedicate to the server.  A minimum of 700MB is recommended.
You must leave enough left over memory for the operating system to run background processes.
If all memory is exhausted the Minecraft server will either crash or force background processes into the paging file (very slow).
Enter amount of memory in megabytes to dedicate to the Minecraft server (recommended: 2700): 
```

Nun wird gefragt wieviel Speicher dem Minecraft Prozess zugeordnet werden soll. Minimal sind 700 MB. Bei einem 32-Bit Prozess sind maximal 2700 MB möglich. Man sollte 2200 eingeben (2700 führte im Test zu Abstürzen) und die Enter-Taste drücken.

```
Enter a name for your server...
Server Name: 
```
 
Nun muss man den Servernamen eingeben. In dem Beispiel wählen wird "GC2".

```
Minecraft can automatically start at boot if you wish.
Start Minecraft server at startup automatically (y/n)?
```

Nun kann man angeben ob der Minecraft Server nach einem Systemstart automatisch gestartet wird. Dies beantworten wir mit Ja, indem wir zuerst y drücken und dann die Enter-Taste. 

```
Your time zone is currently set to Europe/Vienna.  Current system time: Sa 5. Dez 17:27:41 CET 2020
You can adjust/remove the selected reboot time later by typing crontab -e
Automatically reboot Pi and update server at 4am daily (y/n)?
```

Nun wird gefragt ob der Server täglich um 4 Uhr früh neu gestartet werden soll. Das macht Sinn, weil dann die Einstellungen gespeichert werden und eventuelle Updates installiert werden. Wir drücken also y gefolgt von der Enter-Taste.

Nun wird der Server automatisch gestartet.

```
[17:33:50 INFO]: Time elapsed: 3882 ms
[17:33:51 INFO]: Running delayed init tasks
[17:33:51 INFO]: Done (39.914s)! For help, type "help"
[17:33:51 INFO]: Timings Reset
```

In diesem Fall dauerte das Anstarten 40 Sekunden. Die CPU-Last ist zeitweise sehr hoch auf allen Kernen, später pendelt es sich aber auf einem niedrigeren Niveau von ca. 22 % ein. Der Speicherverbrauch ist anfänglich nur auf 17 %. Diese Daten wurden mit top ermittelt.

## Minicraft Server Einstellungen

Alle wichtigen Einstellungen für den Server sind in der Datei “server.properties” gespeichert. Für den Port auf dem der Minecraft Server verfügbar ist, gilt der Parameter “server-port”. Er ist auf den Standardwert 25565 gesetzt. Informationen rund um die Einstellungen können der deutschen Minecraft Gamepedia Seite [Server.properties](https://minecraft-de.gamepedia.com/Server.properties) entnommen werden.  
Man könnte z.B. noch den Schwierigkeitsgrad von Einfach/easy auf Normal/normal setzen.

```
difficulty=normal
```

### Spieler mit Operatorrechten ausstatten

Damit man einen Spieler zum Operator machen kann, muss man zur Server-Konsole wechseln. Dies erfolgt durch den Aufruf von ``screen -r minecraft``.
Dort findet man z. B. diesen Eintrag

```
[17:55:55 INFO]: UUID of player Donald is b47637a4-2f8a-4a47-b43c-c9f32b3c227b
[17:56:00 INFO]: Donald joined the game
[17:56:00 INFO]: Donald[/192.168.0.31:63565] logged in with entity id 1 at ([world]-1274.5, 64.0, -199.5)
```

Nun git man den Befehl ``op`` mit dem Spielernamen als Parameter an, also  ``op Donald`` 
Nun kann man 'screen' mit der Tastenkombination Strg+A und D verlassen. 

In die Datei ops.json sind die Operatoren gespeichert.

```
[
  {
    "uuid": "b47637a4-2f8a-4a47-b43c-c9f32b3c227b",
    "name": "Donald",
    "level": 4,
    "bypassesPlayerLimit": false
  },
  {
    "uuid": "ef341a25-c803-4068-8f00-9bfc4b862eb2",
    "name": "Daisy",
    "level": 4,
    "bypassesPlayerLimit": false
  }
]
```

## Karten wiederherstellen

Sollte man breits Karten aus einem Backup oder einer anderen Quelle haben, so können diese am Server eingespielt werden.

*Backup Inhalt auflisten:* ``tar -tvf backups/2021.01.03_04.00.39.tar.gz``


*Minecraft Welten von Backup wiederherstellen:*

```
sudo service minecraft stop
cd ~/minecraft/
rm -r world world_nether/ world_the_end/
tar xvf ~/minecraft/backups/2021.01.04_04.00.39.tar.gz ./world/ ./world_nether/ ./world_the_end/
sudo service minecraft start
```

## Verlinkung

Originale englischen Anleitung von [James A. Chambers](https://jamesachambers.com/raspberry-pi-minecraft-server-script-with-startup-service/)  
Git Hub Reporitory für [Setup](https://github.com/TheRemote/RaspberryPiMinecraft)  
Unterstützte Paper Minecraft [Versionen](https://papermc.io/api/v1/paper)  
Minecraft Gamepedia [Server.properties](https://minecraft-de.gamepedia.com/Server.properties)

