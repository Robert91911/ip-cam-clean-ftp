# Info del proyecto

Las cámaras IP en FTP no borran cuando se llena el disco duro, así que necesito crear un script que borre los archivos antiguos para que pueda grabar los nuevos.

**Nota:** Actualmente la carpeta record, guarda también las alarmas y las grabaciones mezcladas y quiero separarlas.


## Estructura de directorios

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install foobar.

```bash
HDD-1_IP_2TB/
├── foscam
│   ├── IP-10
│   │   └── FoscamCamera_00626EE96F9F
│   │       ├── alarm
│   │       ├── record
│   │       └── snap
│   ├── IP-11
│   │   └── FoscamCamera_00626ED8B349
│   │       ├── alarm
│   │       ├── record
│   │       └── snap
│   ├── IP-12
│   │   └── FoscamCamera_00626ED8B258
│   │       ├── alarm
│   │       ├── record
│   │       └── snap
│   └── IP-13
│       └── FoscamCamera_00626ED8B32E
│           ├── alarm
│           ├── record
│           └── snap
└── lost+found
```

## Tamaños en cada cámara

La IP-10 tiene que tener el doble de espacio que las demás porque graba a 2K, según los cálculos aguanta 3 semanas de grabación ininterrumpida en todas las cámaras. El tamaño total del disco son 2TB

**Tamaño de la carpeta record**
```bash
IP-10 700 GB    #Record
IP-11 350 GB    #Record
IP-12 350 GB    #Record
IP-13 350 GB    #Record
```

**Tamaño de las carpetas snap y alarm**
```bash
#El tamaño es el mismo para todas las cámaras
IP-** 15 GB    #Alarm
IP-** 3 GB     #Snap
```



## License
[GNU](https://www.gnu.org/licenses/gpl-3.0.html)
