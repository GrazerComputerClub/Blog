+++
showonlyimage = false
draft = false
image = "img/SSH.png"
date = "2020-09-26"
title = "SSH ohne Passwort"
writer = "Martin Strohmayer"
categories = ["Raspberry Pi"]
keywords = ["remote", "SSH", "Password"]
weight = 1
Version=Bullseye K5 & K6
+++

Immer das Raspberry Pi Passwort bei der SSH-Anmeldung angeben kann nervig sein. Es geht aber auch ohne Passworteingabe, für manche Programme ist das sogar notwendig.
<!--more-->

## Beschreibung ##

Wenn man sich per SSH auf einem Linux System anmeldet muss man üblicherweise eine Passwort eingeben. Bei dem Raspberry Pi wird das Standard-Passwort "raspberry" verwendet. Wenn man allerdings seinen öffentlichen Schlüssel am System hinterlegt, kann man sich ohne Passwort anmelden. Bei der Verwendung der Extention "Remote Development" für Visual Studio Code ist es sogar verpflichtend.  
Sollte man ein neues Raspbian bzw. Raspberry Pi OS Betriebssystem aufgespielt haben, darf man nicht vergessen die Datei "ssh" auf der boot-Partition anzulegen. So wird nämlich der SSH-Dienst aktiviert.


## Einrichtung Anmeldung ohne Passwort

Auf dem Client-PC, also der der sich auf den Raspberry Pi verbinden will, muss ein Schlüsselpaar für den aktuellen Benutzer (im Beispiel GC2) erstellt werden.
Es macht Sinn erstmals zu überprüfen ob dies bereits geschehen ist. Der Befehl ``ls ~/.ssh`` listet den Inhalt des lokalen ssh Verzeichnisses auf. Wenn der Fehler "Zugriff auf '/home/GC2/.ssh' nicht möglich" ausgegeben wird oder die Dateien "id_rsa.pub" und "id_dsa.pub" nicht vorhanden sind, dann wurden noch keine Schlüssel erstellt. 

### Schlüsselpaar erstellen

Mit folgenden Befehl wir am lokalen System die  Schlüsselpaar erzeugung gestartet:

``ssh-keygen``
  
Bei den nachfolgenden Fragen muss man zuerst angeben wo die Schlüssel-Datei gespeichert wird.
Mit der Eingabetaste wird hier die Standardvorgabe "/home/GC2/.ssh/id_rsa" benutzt. Dann wird nach der Passwortphrase gefragt. Wenn man zwei mal nur die Eingabetaste drückt, wird keine Phrase verwendet. Man drückt also nach dem Befehl einfach 3 mal auf die Eingabetaste.

``` 
Generating public/private rsa key pair.
Enter file in which to save the key (/home/GC2/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/GC2/.ssh/id_rsa.
Your public key has been saved in /home/GC2/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:obyeWjRqZ73w0UuI8RB7vQVZC/r3CcsnwCKIawrYq1g GC2@GC2-Laptop
The key's randomart image is:
+---[RSA 2048]----+
|          . .    |
|         . + .   |
|      . o o .    |
|   . o + = .     |
|  . . X S = +    |
|.. . o @ + * + . |
|o E o B = + + +  |
|o+ o = + + . o   |
|+.. ..o o .      |
+----[SHA256]-----+ 
```

Beim Auflisten des Verzeichnisinhalts ``ls ~/.ssh`` findet man nun die Dateien "id_rsa" und "id_rsa.pub".  

### Schlüssel hinterlegen

Die Datei "id_rsa" enthält den privaten Schlüssel, er bleibt am aktuellen Client System.  
Die Datei "id_rsa.pub" enthält den öffentlichen Schlüssel. Sie muss auf den SSH-Server bzw. den Raspberry Pi kopiert werden. Dies kann mit folgenden Befehl durchgeführt werden 

``ssh-copy-id pi@raspberrypi.local``

raspberrypi.local ist der typische Hostname der Raspberry Pi. Eventuell muss man auch einen anderen Namen oder die IP-Adresse angeben.  
Sollte es bzgl. des Hostnamens oder der aufgelösten IP-Adresse Probleme geben ("Warning: the ECDSA host key for 'raspberrypi.local' differs from the key for the IP address '192.168.137.10'" oder "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!") löscht man sie am besten aus der Liste der bekannten Verbindungen. Zur Ermittlung der IP-Adresse könnte man den Befehl ``ping -c1 raspberrypi.local`` ausführen.

``ssh-keygen -R raspberrypi.local``  
``ssh-keygen -R 192.168.137.10``  
``ssh-copy-id pi@raspberrypi.local``  

Danach muss man zum letzten mal das Passwort angeben.

```
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 2 key(s) remain to be installed -- if you are prompted now it is to install the new keys
pi@raspberrypi.local's password: 

Number of key(s) added: 2

Now try logging into the machine, with:   "ssh 'pi@raspberrypi.local'"
and check to make sure that only the key(s) you wanted were added.
```


## Verbinden

Verbindet man sich nun per SSH zum Raspberry Pi wird kein Passwort mehr abgefragt.

``ssh pi@raspberrypi.local``

Naürlich kann man auch per SSH Daten transferieren. Dazu verwendet man das program scp (secure copy).
Dabei wird Benutzername und IP-Adresse oder Hostname vor den Pfad gestellt.  

``scp pico-8_0.2.5g_raspi.zip pi@10.0.2.141:/home/pi``
