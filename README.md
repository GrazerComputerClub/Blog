# Grazer Computer Club (alias GC²) - Blog #

Das Team sammelt Informationen zu den Themenbereichen Computer, Raspberry Pi,
Programmierung und sonstige Informatik und stellt sie als Blog zur Verfügung.

Um den Blog zu generieren verwenden wir vom GC²
[Hugo](https://github.com/gohugoio/hugo) als HTML-Generator. Zur Zeit hosten
wir den Blog als *gh-page*, welcher natürlich über unsere primäre Webseite 
[GC²](https://gc2.at/) erreichbar ist.

## Verwendung ##

Damit man den Blog erzeugen kann, muss man zuerst
[Hugo](https://github.com/gohugoio/hugo) installieren.

Anschließend muss man das
[Nederburg-Theme](https://github.com/GrazerComputerClub/hugo-nederburg-theme)
in einen *themes* Unterordner herunterladen.

```bash
~/$ git clone https://github.com/GrazerComputerClub/Blog
~/$ cd Blog
~/Blog$ mkdir themes
~/Blog$ cd themes
~/Blog/themes$ git clone https://github.com/GrazerComputerClub/hugo-nederburg-theme
```

Danach kann man über das Kommando *hugo* die Webseite im "public" Verzeichnis erzeugen.

```bash
~/Blog$ hugo
```

Alternativ kann die Webseite im interne Webserver von Hugo gestartet werden.

```bash
~/Blog$ hugo server 
```

Die Webseite ist nun unter `http://localhost:1313` erreichbar.
