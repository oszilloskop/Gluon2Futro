## USB-Stick - Gluon2Futro (Win / Linux / OS X)
Mit einem präparierten USB-Stick kann ein beliebiges Gluon-x86-Image auf die interne CF-Karte eines Futro S550 übertragen werden.
Der Vorgang ist voll automatisiert. Es wird kein Monitor und keine Tastatur benötigt.

Einfach ein beliebiges Gluon-x86-Image auf den vorbereiteten USB-Stick kopieren. Wird dann der Futro S550 mit diesem vorbereitetem USB-Stick gebootet, so wird das Gluon-x86-Image von dem vorbereitetem USB-Stick auf die interne CF-Karte des Futros übertragen.

---
# ACHTUNG:
### Mit dem vorbereitetem USB-Stick auf keinen Fall einen PC booten!
### Falls das Setup des PCs identisch zu einem Futro S550 ist, so werden alle Daten auf /dev/sda bzw. C:\ gelöscht!
---

### Vorbereitung
Das USB-Stick-Image [gluon2futro.img](https://raw.githubusercontent.com/oszilloskop/Gluon2Futro/master/gluon2futro.img) von GitHub herunterladen und auf einen USB-Stick übertragen. (Der USB-Stick sollte mind. 64 MB groß sein.)
##### Übertragen des USB-Images auf einen USB-Stick
- Windows -> z.B. das Tool [Win32 Disk Imager](http://sourceforge.net/projects/win32diskimager/) benutzen
- mit Linux/OS X -> 'dd if=gluon2futro.img of=/dev/DeinUsbDevice bs=1m' (z.B. /dev/sdb (ohne 1,2,3 etc.))


### Vorgehensweise zum Flashen des Futros:

1) Den vorbereiteten USB-Stick mit einem laufenden PC (Win/Linux/OS X) verbinden.

2) Ein bereits vorhandenes Gluon-x86-Image (mit Endung .img.gz) auf dem USB-Stick löschen.

3) Ein neues komprimiertes Gluon-x86-Image (mit Endung .img.gz) auf den USB-Stick kopieren.

4) Den USB-Stick von dem PC trennen.

5) Den USB-Stick in einen ausgeschalteten Futro S550 stecken.

6) Den Futro S550 einschalten.

7) Warten (je nach CF-Speed ca. 10-60 Sekunden) bis es 5 x piept.
(piep,piep,piep - piep,piep)

8) Der Futro S550 schaltet sich automatisch aus.

9) USB-Stick entfernen und den Futro erneut einschalten.

10) Falls ein Factory-Image verwendet wurde, kann per http://192.168.1.1 auf
die Konfigurationsseite des Futro S550 zugegriffen werden.


### Im Fehlerfall:
-> 10 Sekunden wildes Gepiepse!

Kommt es zu einem Fehler, so fängt der Futro für ca. 10 Sekunden wie wild an
zu piepsen. Hiernach schaltet er sich automatisch aus.
Auf einem, an dem Futro angeschlossenen Monitor, wird die Fehlerursache angezeigt.
(Evtl. könnte man das Skript 'bitte_nicht_loeschen.sh' auf dem vorbereitetem USB-Stick auch noch so anpassen, dass die Fehlerursache in einer Datei auf dem USB-Stick abgelegt wird.)

### Info:
Aus unbekannten Gründen scheitert das korrekte Mounten des USB-Sticks bei einem von zehn Versuchen :o(
Dann piept der Futro wie wild -> nochmal versuchen!

---

### Verwendetes USB-Boot-Linux: Tiny/MicroCore 
siehe http://tinycorelinux.net/

---
<br>
<br>
---
## Futro S550 Bedienung ohne Monitor aber mit angeschlossener Tastatur
Alle Kommandos sollte nacheinander eingegeben werden!

#### "halt on errors" ausschalten, damit der Futro S550 auch ohne Tastatur bootet:
Den Futro S550 starten und immer wieder F2 drücken bis er piept!
- 3x runter
- enter
- enter
- hoch
- enter
- esc

#### "in case of power failure" auf "always on" stellen. Der Futro S550 startet dann sobald er Strom hat.

- 3x rechts
- 3x runter
- enter
- hoch
- enter

#### Speichern und beenden

- F10
- enter

#### Booten von USB Stick

ganz oft F12 drücken (ruhig nen paar Sekunden um sicher zu sein, dass der boot screen durch ist)

- 2x runter
- enter
