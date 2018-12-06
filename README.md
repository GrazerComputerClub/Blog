# Grazer Computer Club (alias GC²) - Blog #

Das Team sammelt Informationen zu den Themenbereichen Computer, Raspberry Pi,
Programmierung und sonstige Informatik und stellt sie als Blog zur Verfügung.

Um den Blog zu generieren verwendet wir vom GC²
[Hugo](https://github.com/gohugoio/hugo) als HTML-Generator. Zur Zeit hosten
wir den Blog als *gh-page*, welche natürlich über unsere primäre Webseite 
[GC²](https://gc2.at/) erreichbar ist.

## Verwendung ##

Damit man den Blog erzeugen kann, muss man zuerst
[Hugo](https://github.com/gohugoio/hugo) installieren.

Anschließend muss man das
[Nederburg-Theme](https://themes.gohugo.io/hugo-nederburg-theme/) in einen 
*themes* Unterordner herunterladen.

```bash
~/Blog$ mkdir themes
~/Blog$ cd themes
~/Blog/themes$ git clone https://github.com/appernetic/hugo-nederburg-theme.git
```

Danach kann man über das Kommando *hugo* die Webseite erzeugen.

```bash
~/Blog$ hugo
```
