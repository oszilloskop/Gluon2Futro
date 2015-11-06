#!/bin/sh
##############################################
#
# Auto-Skript-Sammlung "Gluon2Futro ueber USB"
#
# Diese Skripte sind auf die Hardware eines
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

# Machmal ist der Init-Prozess noch nicht rum!
# Daher einfach mal etwas warten...
sleep 2s

echo
echo
echo "################################################################################"
echo "#                                                                              #"
echo "#                       GLUON auf Futro S550 Autoinstaller                     #"
echo "#                                                                              #"
echo "################################################################################"
echo
echo

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

