#!/bin/sh
##############################################
#
# Auto-Skript-Sammlung "Gluon2Futro ueber USB"
#
# Die Skripte sind auf die Hardware eines
# Fujitsu Siemens Futro S550 abgestimmt.
#
# Mit andere Hardware koennen,
# mussen sie aber nicht funktionieren!
#
# Benutzung nur auf eigene Gefahr!
#
##############################################

Sirene () {
  COUNTER=50
  while [ $COUNTER != "0" ]
  do
    echo -e "\a" > /dev/tty7
    sleep 0.2
    COUNTER=$((COUNTER - 1))
  done
}

echo
echo
echo "################################################################################"
echo "#                                                                              #"
echo "#                       GLUON auf Futro S550 Autoinstaller                     #"
echo "#                                                                              #"
echo "################################################################################"
echo
echo

# Manchmal ist der Init-Prozess noch nicht rum! 
# Daher einfach mal 1 Sekunde warten
sleep 1s

mount /dev/sdb1
if [ $? != "0" ]; then
  echo Fehler: Kann USB-Partition mit Gluon-Image-Datei nicht einbinden!
  echo Abbruch!
  echo
  Sirene
  sudo poweroff
  exit
else
  echo USB-Partition mit Gluon-Image-Datei erfolgreich eingebunden.
fi
echo

cd /mnt/sdb1

/bin/sh bitte_nicht_loeschen.sh

if [ $? != "0" ]; then
  cd
  sudo umount /mnt/sdb1
  Sirene
else
  sudo umount /mnt/sdb1
fi

sudo poweroff

