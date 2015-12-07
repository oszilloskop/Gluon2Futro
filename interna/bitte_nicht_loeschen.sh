#!/bin/sh

######################################################################################
#
# ACHTUNG:
# Mit diesem USB-Stick auf keinen Fall einen PC booten!
# Falls das Setup des PCs identisch zu einem Futro S550 ist,
# so werden alle Daten auf /dev/sda bzw. C:\ geloescht!
#
######################################################################################


######################################################################################
#
# Vorgehensweise zum Flashen des Futros:
#
#  1) Den vorbereiteten USB-Stick mit einem laufenden PC verbinden.
#
#  2) Ein bereits vorhandenes Gluon-x86-Image (mit Endung .img.gz) auf dem USB-Stick loeschen.
#
#  3) Ein neues komprimiertes Gluon-x86-Image (mit Endung .img.gz) auf den USB-Stick kopieren.
#
#  4) Den USB-Stick von dem PC trennen.
#
#  5) Den USB-Stick in einen ausgeschalteten Futro S550 stecken.
#
#  6) Den Futro S550 einschalten.
#
#  7) Warten (je nach CF-Speed ca. 20-60 Sekunden) bis es 5 x piept.
#    (piep,piep,piep - piep,piep)
#
#  8) Der Futro S550 schaltet sich automatisch aus.
#
#  9) USB-Stick entfernen und den Futro erneut einschalten.
#
# 10) Falls ein Factory-Image verwendet wurde, kann per http://192.168.1.1 auf
#     die Konfigurationsseite des Futro S550 zugegriffen werden.
#
#
# Im Fehlerfall:
# -> 10 Sekunden wildes Gepiepse!
#
# Kommt es zu einem Fehler, so faengt der Futro fuer ca. 10 Sekunden wie wild an
# zu piepsen. Hiernach schaltet er sich automatisch aus.
# Auf einem, an dem Futro angeschlossenen Monitor, wird die Fehlerursache angezeigt.
# (Evtl. koennte man dieses Skript auch noch so anpassen, dass die Fehlerursache
# in einer Datei abgelegt wird.)
#
# Info:
# Aus unbekannten Gruenden scheitert das korrekte Mounten des USB-Sticks
# bei einem von zehn Versuchen :o(
# Dann piept der Futro wie wild -> nochmal versuchen!
#
######################################################################################

######################################################################################
#
# Dieses Skript wird am Ende des USB-Bootenvorgangs aufgerufen.
#
# Aufrufreihenfolge: /home/tc/.profile -> /home/tc/start.sh -> dieses USB-Skript
#
# Das aufrufende Skript wertet den Rueckgabewert dieses Skriptes aus:
#  - exit 1
#    fuehrt zu ca. 10 Sekunden wildem Gepiepse, dann Shoutdown
#
#  - exit, exit 0
#    fuehrt zu einem Shutdown ohne akustische Meldung
#
######################################################################################


# Wir befinden uns bereits auf dem USB-Stick ( /mnt/sdb1/ )
#
# Los geht's


# Sicherheitstest, ob es sich wirklich um einen Prozessor eines Futro S550 handelt
echo Teste auf AMD Sempron Prozessor...
echo
if ! (grep -Fq "Mobile AMD Sempron(tm) Processor 2100+" /proc/cpuinfo) ; then
  echo
  echo Fehler: Kein AMD Sempron Prozessor 2100+ gefunden.
  echo Fehlergrund: Es handel sich wohl nicht um einen Futro S550.
  echo
  exit 1
fi

# Komprimierte Image-Datei auf USB-Stick suchen
echo Suche Image...
echo
IMAGECOUNT=$(ls *.img.gz | wc -l)
if [ $IMAGECOUNT != "1" ]; then
  echo Fehler: Kein oder mehr als ein Image gefunden!
  echo Abbruch!
  echo
  exit 1
fi

# Informationsausgabe
IMAGE=$(ls *.img.gz)
echo Folgendes Image wird verwendet:
echo $IMAGE
echo

# Image-Datei nach /tmp/gluon.img entpacken
echo Entpacke Image...
echo
gzip -dc $IMAGE > /tmp/gluon.img
if [ $? != "0" ]; then
  echo Fehler: Konnte Image nicht entpacken.
  echo Abbruch!
  exit 1
fi

# Kopiervorgang durchfuehren
echo Kopiere Image auf interne CF-Karte...
echo
dd if=/tmp/gluon.img of=/dev/sda bs=1M
if [ $? != "0" ]; then
  echo Fehler: Konnte Image nicht auf interne CF-Karte kopieren.
  echo Abbruch!
  exit 1
fi

# Zur Sicherheit mal den Write Buffer weg schreiben
echo
echo Schreibe Write-Buffer...
sync
if [ $? != "0" ]; then
  echo Fehler: Konnte Write-Buffer nicht ordentlich weg schreiben.
  echo Abbruch!
  exit 1
fi
echo

# Fertig
echo Das Image aus $IMAGE wurde erfolgreich auf die interne CF-Karte kopiert.
echo
echo
echo Bitte den USB-Stick entfernen und das System neu starten.
echo

# Alles o.k. -> 5 x Beep (3x - kurze Pause - 2x)
echo -e "\a" > /dev/tty7
sleep 0.3
echo -e "\a" > /dev/tty7
sleep 0.3
echo -e "\a" > /dev/tty7
sleep 0.5
echo -e "\a" > /dev/tty7
sleep 0.3
echo -e "\a" > /dev/tty7


# Wenn alles o.k. ist, immer mit "exit 0" beenden. 
# Ansonsten koennte das Gepiepse losgehen...
exit 0
