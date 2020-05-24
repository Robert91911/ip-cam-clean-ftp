#!/bin/bash

MAIN_DIR="/home/robert/HDD-1_IP_2TB/foscam"

#Nombes de los directorios
record_dir="record"
alarm_dir="alarm"
snap_dir="snap"

#Espacio por cámara
IP10_space=700
IP11_space=350
IP12_space=350
IP13_space=350

#Espacio para las alarmas, cada camara 15GB en este caso
EspacioAlarmas=15

#Espacio para las snap (fotos de cada alarma)
EspacioSnap=3


arrayDirectoriosRecord=()
readarray -d '' arrayDirectoriosRecord < <(find $PWD -name "$record_dir" -print0 | sort -z)

arrayDirectoriosAlarm=()
readarray -d '' arrayDirectoriosAlarm < <(find $PWD -name "$alarm_dir" -print0 | sort -z)

arrayDirectoriosSnap=()
readarray -d '' arrayDirectoriosSnap < <(find $PWD -name "$snap_dir" -print0 | sort -z)

######### Mover las alarmas a su carpeta correspondiente #########

Bucle para el copiado de archivos
for i in 0 1 2 3; do
        echo "Se estan moviendo los archivos de la camara" $i
        #Mover los archivos
        mv -n "${arrayDirectoriosRecord[i]}/HMalarm"* "${arrayDirectoriosAlarm[i]}/"
done

echo "######################## ORGANIZACION DE ALERTAS REALIZADA ########################"
#Bucle para la eliminación de archivos cuando se haya pasado de espacio

#record
for i in 0 1 2 3; do
	echo "Se esta verificando el espacio de la carpeta record de la camara " $i
	espacioOcupado=$(du ${arrayDirectoriosRecord[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
	espacioAsignado="IP1"$i"_space"
	echo $espacioOcupado
		while [ $espacioOcupado -gt ${!espacioAsignado} ]; do
			echo "El espacio para esta camara es " ${!espacioAsignado}
			archivoMasAntiguo=$(find ${arrayDirectoriosRecord[i]} -type f | sort | head -n 1)
			echo "Se ha eliminado el archivo mas antiguo, espacio actual = " $espacioOcupado
			rm $archivoMasAntiguo -v
			espacioOcupado=$(du ${arrayDirectoriosRecord[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
		done
done

echo "######################## ELIMINACION DE RECORD REALIZADA ########################"

#alarm
for i in 0 1 2 3; do
	echo "Se esta verificando el espacio de la carpeta alarm de la camara " $i
	espacioOcupado=$(du ${arrayDirectoriosAlarm[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
	espacioAsignado="EspacioAlarmas"
	echo $espacioOcupado
		while [ $espacioOcupado -gt ${!espacioAsignado} ]; do
			echo "El espacio para esta camara es " ${!espacioAsignado}
			archivoMasAntiguo=$(find ${arrayDirectoriosAlarm[i]} -type f | sort | head -n 1)
			echo "Se ha eliminado el archivo mas antiguo, espacio actual = " $espacioOcupado
			rm $archivoMasAntiguo -v
			espacioOcupado=$(du ${arrayDirectoriosAlarm[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
		done
done

echo "######################## ELIMINACION DE ALARM REALIZADA ########################"

#snap
for i in 0 1 2 3; do
	echo "Se esta verificando el espacio de la carpeta snap de la camara " $i
	espacioOcupado=$(du ${arrayDirectoriosSnap[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
	espacioAsignado="EspacioSnap"
	echo $espacioOcupado
		while [ $espacioOcupado -gt ${!espacioAsignado} ]; do
			echo "El espacio para esta camara es " ${!espacioAsignado}
			archivoMasAntiguo=$(find ${arrayDirectoriosSnap[i]} -type f | sort | head -n 1)
			echo "Se ha eliminado el archivo mas antiguo, espacio actual = " $espacioOcupado
			rm $archivoMasAntiguo -v
			espacioOcupado=$(du ${arrayDirectoriosSnap[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
		done
done

echo "######################## ELIMINACION DE SNAP REALIZADA ########################"

