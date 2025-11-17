# gVoCC_Carnivora_Maps.R

Este repositorio contiene el script `scripts/gVoCC_Carnivora_Maps.R` para calcular y visualizar la velocidad climática (gVoCC) usando datos CRU TS y la librería `VoCC`.

## Archivos esperados
El script asume que los siguientes archivos o recursos están disponibles en el directorio donde se ejecuta (o en rutas relativas):

- `cru_ts4.08.1901.2023.tmn.dat.nc`  (tmin monthly CRU TS NetCDF)
- `cru_ts4.08.1901.2023.tmx.dat.nc`  (tmax monthly CRU TS NetCDF)
- `auxilary_functions.R` (funciones auxiliares requeridas por el script)
- `./shapes/countries.shp` y archivos asociados del shapefile (`.dbf`, `.shx`, etc.)

> Nota: en tu entorno local original los datos estaban en Dropbox: `C:\Users\Julian\Dropbox\Proyectos\ExtinctionRisk_ClimateChange\gVoCC\scripts`.

## Dependencias de R
El script usa muchas librerías; instala al menos las siguientes (lista sin orden):

- raster, terra, sf, sp, rgdal, rgeos, maptools
- VoCC
- ncdf4, RNetCDF, ncdf4.helpers
- rasterVis, lattice, ggplot2, ggpubr, ggstatsplot, ggrepel
- RColorBrewer, viridisLite, colorspace, dichromat
- dismo, maps, classInt
- plyr, dplyr, reshape2
- plotKML, rlist, qpcR, climetrics

Puedes instalarlas en R con algo como:

```r
pkgs <- c("raster","terra","sf","sp","rgdal","rgeos","maptools",
		  "VoCC","ncdf4","RNetCDF","ncdf4.helpers","rasterVis","lattice",
		  "ggplot2","ggpubr","ggstatsplot","ggrepel","RColorBrewer","viridisLite",
		  "colorspace","dichromat","dismo","maps","classInt","plyr","dplyr",
		  "reshape2","plotKML","rlist","qpcR","climetrics")
install.packages(setdiff(pkgs, installed.packages()[,"Package"]))
```

Algunas dependencias (p. ej. `rgdal`, `sf`) requieren librerías del sistema (GDAL/PROJ). En Linux asegúrate de tenerlas instaladas antes de instalar los paquetes R.

## Cómo ejecutar
Desde la carpeta raíz del repo (donde está `scripts/`):

- Ejecutar en R interactivo (recomendado para depuración):

```r
setwd("/ruta/al/repo/ClimateChangeVelocity")
source("scripts/gVoCC_Carnivora_Maps.R")
```

- Ejecutar con `Rscript` (modo batch):

```bash
Rscript scripts/gVoCC_Carnivora_Maps.R
```

## Copiar datos desde Windows (ejemplos)
Si los datos están en tu máquina Windows en Dropbox (ruta original que mencionaste), puedes copiar los archivos al repo local. Ejemplos:

PowerShell (en Windows):

```powershell
$src = "C:\Users\Julian\Dropbox\Proyectos\ExtinctionRisk_ClimateChange\gVoCC\scripts\"
$dst = "C:\path\to\your\repo\ClimateChangeVelocity\scripts\"
New-Item -ItemType Directory -Force -Path $dst
Copy-Item -Path "$src\cru_ts4.08.1901.2023.tmn.dat.nc" -Destination $dst
Copy-Item -Path "$src\cru_ts4.08.1901.2023.tmx.dat.nc" -Destination $dst
Copy-Item -Path "$src\auxilary_functions.R" -Destination $dst
# Copiar la carpeta shapes completa si la tienes
Copy-Item -Path "C:\path\to\shapes\*" -Destination "C:\path\to\your\repo\ClimateChangeVelocity\shapes\" -Recurse
```

Git Bash / WSL (ajusta rutas):

```bash
mkdir -p /c/path/to/your/repo/ClimateChangeVelocity/scripts
cp "/c/Users/Julian/Dropbox/Proyectos/ExtinctionRisk_ClimateChange/gVoCC/scripts/cru_ts4.08.1901.2023.tmn.dat.nc" /c/path/to/your/repo/ClimateChangeVelocity/scripts/
cp "/c/Users/Julian/Dropbox/Proyectos/ExtinctionRisk_ClimateChange/gVoCC/scripts/cru_ts4.08.1901.2023.tmx.dat.nc" /c/path/to/your/repo/ClimateChangeVelocity/scripts/
cp "/c/Users/Julian/Dropbox/Proyectos/ExtinctionRisk_ClimateChange/gVoCC/scripts/auxilary_functions.R" /c/path/to/your/repo/ClimateChangeVelocity/scripts/
# shapes:
mkdir -p /c/path/to/your/repo/ClimateChangeVelocity/shapes
cp -r "/c/path/to/shapes/" /c/path/to/your/repo/ClimateChangeVelocity/shapes/
```

## Archivos generados por el script
El script escribe estos archivos al ejecutarse:

- `gvocc_tmin.p3.nc`
- `gvocc_tmax.p3.nc`
- `gVoCC_periods.jpg`
- `gVoCC_absolute_values_periods.jpg`
- `Mapas_gVoCC_periodos.RData`

Asegúrate de tener suficiente espacio en disco y permisos de escritura.

## Validación rápida (en este repositorio)
He verificado que actualmente NO existen en el repo:

- `cru_ts4.08.1901.2023.tmn.dat.nc`
- `cru_ts4.08.1901.2023.tmx.dat.nc`
- `auxilary_functions.R`
- `shapes/countries.shp` (y los archivos .dbf/.shx asociados)

Si quieres, puedo añadir scripts/ejemplos para descargar datos CRU o instrucciones más detalladas para instalar dependencias del sistema.

## Commit
Este README ha sido añadido al repo. Si quieres otro contenido o lenguaje, dímelo y lo ajusto.

# ClimateChangeVelocity