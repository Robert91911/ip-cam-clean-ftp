#!/bin/bash

MAIN_DIR="/home/robert/HDD-1_IP_2TB/HDD-1_IP_2TB/foscam/"
FECHA=$(date)


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
readarray -d '' arrayDirectoriosRecord < <(find $MAIN_DIR -name "$record_dir" -print0 | sort -z)

arrayDirectoriosAlarm=()
readarray -d '' arrayDirectoriosAlarm < <(find $MAIN_DIR -name "$alarm_dir" -print0 | sort -z)

arrayDirectoriosSnap=()
readarray -d '' arrayDirectoriosSnap < <(find $MAIN_DIR -name "$snap_dir" -print0 | sort -z)

echo "#############################################################################################"
echo "#			Se realizaran las tareas de limpieza de las camaras IP						  	  #"
echo "#############################################################################################"

echo " "
echo " Dia y hora de la limpieza $FECHA"
echo " "

######### Mover las alarmas a su carpeta correspondiente #########
echo "######################## REALIZANDO ORGANIZACION DE ALERTAS ########################"
#Bucle para el copiado de archivos
for i in 0 1 2 3; do
        echo "Se estan moviendo los archivos de la camara IP1$i"
        #Mover los archivos
        mv  "${arrayDirectoriosRecord[i]}/HMalarm"* "${arrayDirectoriosAlarm[i]}/" 2>/dev/null
done

#Bucle para la eliminación de archivos cuando se haya pasado de espacio

#record
echo " "
echo "######################## ESCANEO Y ELIMINACION DE RECORD ########################"
for i in 0 1 2 3; do
	espacioAsignado="IP1"$i"_space"
	echo "---------------------------------------------------------------------------------"
	echo "Se esta verificando el espacio de la carpeta RECORD de la camara IP1$i"
	echo "Espacio especificado: " ${!espacioAsignado} "GB"
	espacioOcupado=$(du ${arrayDirectoriosRecord[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
	echo "Espacio ocupado: " $espacioOcupado " GB"
		while [ $espacioOcupado -gt ${!espacioAsignado} ]; do
			archivoMasAntiguo=$(find ${arrayDirectoriosRecord[i]} -type f | sort | head -n 1)
			echo "Eliminando archivo: "$archivoMasAntiguo
			rm $archivoMasAntiguo -v
			espacioOcupado=$(du ${arrayDirectoriosRecord[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
			echo "El espacio ocupado actual es: " $espacioOcupado " GB"
		done
done

echo "---------------------------------------------------------------------------------"

#alarm
echo " "
echo "######################## ESCANEO Y ELIMINACION DE ALARM ########################"
for i in 0 1 2 3; do
	espacioAsignado="EspacioAlarmas"
	echo "---------------------------------------------------------------------------------"
	echo "Se esta verificando el espacio de la carpeta alarm de la camara IP1$i"
	espacioOcupado=$(du ${arrayDirectoriosAlarm[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
	echo "Espacio ocupado: " $espacioOcupado " GB"
		while [ $espacioOcupado -gt ${!espacioAsignado} ]; do
			archivoMasAntiguo=$(find ${arrayDirectoriosAlarm[i]} -type f | sort | head -n 1)
			echo "Eliminando archivo: "$archivoMasAntiguo
			rm $archivoMasAntiguo -v
			espacioOcupado=$(du ${arrayDirectoriosAlarm[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
			echo "El espacio ocupado actual es: " $espacioOcupado " GB"
		done
done

echo "---------------------------------------------------------------------------------"

#snap
echo " "
echo "######################## ESCANEO Y ELIMINACION DE SNAP ########################"
for i in 0 1 2 3; do
	espacioAsignado="EspacioSnap"
	echo "---------------------------------------------------------------------------------"
	echo "Se esta verificando el espacio de la carpeta snap de la camara IP1$i"
	espacioOcupado=$(du ${arrayDirectoriosSnap[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
	echo "Espacio ocupado: " $espacioOcupado " GB"
		while [ $espacioOcupado -gt ${!espacioAsignado} ]; do
			archivoMasAntiguo=$(find ${arrayDirectoriosSnap[i]} -type f | sort | head -n 1)
			echo "Eliminando archivo: "$archivoMasAntiguo
			rm $archivoMasAntiguo -v
			espacioOcupado=$(du ${arrayDirectoriosSnap[i]} --si --block-size=1G | grep -Eo '[0-9]{1,4}' | head -n 1)
			echo "El espacio ocupado actual es: " $espacioOcupado " GB"
		done
done

echo "---------------------------------------------------------------------------------"
