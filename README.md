# gVoCC_Carnivora_Maps.R

Este repositorio contiene el script `scripts/gVoCC_Carnivora_Maps.R` para calcular y visualizar la velocidad climática (gVoCC) usando datos CRU-TS y la librería `VoCC`.

## Archivos esperados
El script asume que los siguientes archivos o recursos están disponibles en el directorio donde se ejecuta (o en rutas relativas):

- `cru_ts4.08.1901.2023.tmn.dat.nc`  (tmin monthly CRU TS NetCDF)
- `cru_ts4.08.1901.2023.tmx.dat.nc`  (tmax monthly CRU TS NetCDF)
- `auxilary_functions.R` (funciones auxiliares requeridas por el script)
- `./shapes/countries.shp` y archivos asociados del shapefile (`.dbf`, `.shx`, etc.)

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

Algunas dependencias (p. ej. `rgdal`, `sf`) requieren librerías del sistema (GDAL/PROJ). 
