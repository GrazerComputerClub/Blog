
+++
showonlyimage = false
draft = false
image = "img/esp8266_i2c_display_weather.jpg"
date = "2018-12-13"
title = "Wetteranzeige mittels ESP8266 und I²C Display"
writer = "Christoph Woergoetter"
categories = ["ESP8266"]
keywords = ["WiFi", "WLAN", "ESP8266", "I²C"]
weight = 1
+++

Ein einfaches Info-Display kann recht schnell erreicht werden. Es reicht ein
ESP8266 und ein Display welches über I²C angesprochen werden kann. In diesem
Aufbau wurde mittels eines ESP8266 Boards ein Display mit SSD1306 Chip über I²C
mit Daten von OpenWeather befüllt.
<!--more-->

## Umsetzung ##

Für die Umsetzung muss man 

* das I²C Display über den ESP8266 ansteuern 
* den ESP8266 mit dem eigenen WiFi verbinden
* Daten von OpenWeather abrufen.

### WiFi mit ESP8266 ###

Jeder der schon einmal einen ESP8266 verwendet hat, wird sicherlich auch schon
einmal das primäre Merkmal des ESP8266-Chips verwendet haben - das Wlan-Modul.

```cpp
// ...
WiFi.mode(WIFI_STA);
WiFi.config(m_ip, m_gateway, m_subnet, m_dns);
WiFi.setAutoReconnect(true);
WiFi.begin(m_ssid.c_str(), m_password.c_str());
// ...
```

### Display ###

Um das Display über den ESP8266 anzusteuern, kann man bereits auf ein paar 
vorhandene Bibliotheken aufbauen. Verwendet man für das Projekt die PlatformIO-IDE,
so muss man nur folgende Bibliotheken als Abhängigkeiten setzen:

```cpp
ESP_SSD1306
Adafruit GFX Library
```

Um das Display anschließend zu initialisieren sind folgende Zeilen notwendig:
```cpp
// RST_PIN ... Reset-Pin muss geändert werden wenn die Default-I²C Pins
// verwendet werden
ESP_SSD1306 display(RST_PIN);
// SSD1306_SWITCHCAPVCC ... Displayspannung intern generieren
// 0x3C ... I²C Adresse
display.begin(SSD1306_SWITCHCAPVCC, 0x3C);

// Initialen Buffer anzeigen
display.display();
```

Damit Wetterdaten angezeigt werden können, muss das Display zyklisch gelöscht
und die Daten wieder neu aufgebaut werden. Hierfür kann über `clearDisplay()`
zuerst das Display gelöscht und anschließend entsprechend über die
dazugehörigen Grafikfunktionen die Daten neu gezeichnet werden.
Für die Anzeige der Wetterdaten wurde folgender Code verwendet:
```cpp
display.setTextSize(2);
display.setCursor(0, 16);
display.print("  ");
display.print(m_lastTemp);
display.print((char)248); display.println("C");
display.print("  ");
display.print(m_lastHum); display.println("%");
```

![Display](../../img/esp8266_i2c_display_weather_detail.jpg) 


### OpenWeather ###

Um Daten von OpenWeather abzurufen, muss man sich zuvor registrieren. Anschließend
kann man in seinem Profil einen API-Key generieren, welchen man in der eigenen
Anwendung verwenden kann.

OpenWeather besitzt für das Abrufen der Daten ein Rest-Interface. Dieses kann 
durch den ESP8266 leicht abgerufen werden:

```cpp
WiFiClient client;
client.connect("api.openweathermap.org", 80);

String uri = "/data/2.5/weather?id=";
uri += ID;
uri += "&appid=";
uri += APP_ID;
uri += "&units=metric";
client.print(String("GET ") 
  + uri + " HTTP/1.1\r\n" +
  "Host: " + HOST + "\r\n" +
  "Connection: close\r\n\r\n");

while (client.available() == 0) {
  // Auf Daten warten
}

String line;
while(client.available()) {
  line += client.readStringUntil('\r');
}
```

Anschließend muss der empfangene Rest-String geparsed werden. Hierfür existieren
unendlich viele Rest-Bibliotheken. Jedoch besteht die einfachste Variante
darin, die notwendigen Daten einfach aus dem Rest-String herauszuschneiden.

```cpp
auto dataExtractor = [&](String searchPattern) {
  int idx = line.indexOf(searchPattern);
  int delTokenIdx = line.indexOf(",", idx);
  if (delTokenIdx < 0)
    delTokenIdx = line.indexOf("}", idx);
  if (delTokenIdx < 0) {
    return 0.0f;
  }
  return line.substring(idx + searchPattern.length(), delTokenIdx).toFloat();
};
m_temp = dataExtractor("\"temp\":");
m_humidity = dataExtractor("\"humidity\":");
```

