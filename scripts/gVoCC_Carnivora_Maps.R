library(raster)
library(sf)
library(sp)
library(maptools)
library(rgdal)
library(dismo)
library(XML)
library(maps)
library(plyr)
library(rgeos)
library(classInt)
library(rcompanion)
library(reshape2)
library(qpcR)
library(plotKML)
library(elliplot)
library(RColorBrewer)
library(VoCC)
library(rlist)
library(RNetCDF)
library(ncdf4)
library(ncdf4.helpers)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(ggpubr)
library(lattice)
library(rasterVis)
library(climetrics)

library(RColorBrewer)
library(terra)
library(reshape2)
library(ggplot2)
library(ggstatsplot)
library(rasterVis)
library(viridisLite)

library(dichromat)
library(colorspace)


# cru-ts datasets
tmin <- brick("cru_ts4.08.1901.2023.tmn.dat.nc")
tmax <- brick("cru_ts4.08.1901.2023.tmx.dat.nc")

# calculate mean annual monthly temp
yr.tmin <- sumSeries(tmin, p = "1901-01/2023-12", yr0 = "1901-01-01", l = nlayers(tmin),
                        fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")
yr.tmax <- sumSeries(tmax, p = "1901-01/2023-12", yr0 = "1901-01-01", l = nlayers(tmax),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")


# temporal trend and gradient-based velocity
tr.tmin <- tempTrend(yr.tmin, th=30)
sg.tmin <- spatGrad(yr.tmin, th = 0.1, projected = FALSE)
gvocc.tmin <- gVoCC(tr.tmin, sg.tmin)

tr.tmax <- tempTrend(yr.tmax, th=30)
sg.tmax <- spatGrad(yr.tmax, th = 0.1, projected = FALSE)
gvocc.tmax <- gVoCC(tr.tmax, sg.tmax)

#

# calculate mean annual monthly temp
yr.tmin <- sumSeries(tmin, p = "1901-01/2023-12", yr0 = "1901-01-01", l = nlayers(tmin),
                        fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")
yr.tmax <- sumSeries(tmax, p = "1901-01/2023-12", yr0 = "1901-01-01", l = nlayers(tmax),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")



# calculate mean annual monthly temp
yr.tmin.p1 <- sumSeries(tmin, p = "1901-01/1950-12", yr0 = "1901-01-01", l = nlayers(tmin),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")

yr.tmax.p1 <- sumSeries(tmax, p = "1901-01/1950-12", yr0 = "1901-01-01", l = nlayers(tmax),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")

yr.tmin.p2 <- sumSeries(tmin, p = "1951-01/1990-12", yr0 = "1951-01-01", l = nlayers(tmin),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")

yr.tmax.p2 <- sumSeries(tmax, p = "1951-01/1990-12", yr0 = "1951-01-01", l = nlayers(tmax),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")

yr.tmin.p3 <- sumSeries(tmin, p = "1991-01/2018-12", yr0 = "1991-01-01", l = nlayers(tmin),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")

yr.tmax.p3 <- sumSeries(tmax, p = "1991-01/2018-12", yr0 = "1991-01-01", l = nlayers(tmax),
                     fun = function(x) colMeans(x, na.rm = TRUE), freqin = "months", freqout = "years")



# temporal trend and gradient-based velocity
tr.tmin.p1 <- tempTrend(yr.tmin.p1, th=30)
sg.tmin.p1 <- spatGrad(yr.tmin.p1, th = 0.1, projected = FALSE)
gvocc.tmin.p1 <- gVoCC(tr.tmin.p1, sg.tmin.p1)

tr.tmax.p1 <- tempTrend(yr.tmax.p1, th=30)
sg.tmax.p1 <- spatGrad(yr.tmax.p1, th = 0.1, projected = FALSE)
gvocc.tmax.p1 <- gVoCC(tr.tmax.p1, sg.tmax.p1)

tr.tmin.p2 <- tempTrend(yr.tmin.p2, th=30)
sg.tmin.p2 <- spatGrad(yr.tmin.p2, th = 0.1, projected = FALSE)
gvocc.tmin.p2 <- gVoCC(tr.tmin.p2, sg.tmin.p2)

tr.tmax.p2 <- tempTrend(yr.tmax.p2, th=30)
sg.tmax.p2 <- spatGrad(yr.tmax.p2, th = 0.1, projected = FALSE)
gvocc.tmax.p2 <- gVoCC(tr.tmax.p2, sg.tmax.p2)

tr.tmin.p3 <- tempTrend(yr.tmin.p3, th=20)
sg.tmin.p3 <- spatGrad(yr.tmin.p3, th = 0.1, projected = FALSE)
gvocc.tmin.p3 <- gVoCC(tr.tmin.p3, sg.tmin.p3)

tr.tmax.p3 <- tempTrend(yr.tmax.p3, th=20)
sg.tmax.p3 <- spatGrad(yr.tmax.p3, th = 0.1, projected = FALSE)
gvocc.tmax.p3 <- gVoCC(tr.tmax.p3, sg.tmax.p3)


writeRaster(gvocc.tmin.p3[[1]], "gvocc_tmin.p3.nc", overwrite=T,
            format="CDF", varname="gvocc", varunit="km/year", xname="X",
            yname="Y", zname="nbands", zunit="numeric")

writeRaster(gvocc.tmax.p3[[1]], "gvocc_tmax.p3.nc", overwrite=T,
            format="CDF", varname="gvocc", varunit="km/year", xname="X",
            yname="Y", zname="nbands", zunit="numeric")


tmin <- raster("gvocc_tmin.p3.nc")
tmax <- raster("gvocc_tmax.p3.nc")


xx <- stack(tmin, tmax)
names(xx) <- c("tmin", "tmax")

myTheme <- rasterTheme(region = rev(sequential_hcl(11, "Reds 3")))
plr1 <- levelplot(xx, at=my.at, par.settings = myTheme, margin=FALSE, main="Gradient-based climate velocity")
plr2 <- plr1 + latticeExtra::layer(sp.lines(st_outline, col="gray30", lwd=1))
plr2
diverge0(plr1, ramp=colorRampPalette(rev(brewer.pal(9,"RdBu"))))


xxx <- stack(gvocc.tmin.p1[[1]], gvocc.tmax.p1[[1]], gvocc.tmin.p2[[1]],
             gvocc.tmax.p2[[1]], gvocc.tmin.p3[[1]], gvocc.tmax.p3[[1]])
names(xxx) <- c("tmin_1901_1950", "tmax_1901_1950", "tmin_1951_1990",  "tmax_1951_1990",
                "tmin_1991_2018", "tmax_1991_2018")

xxx2 <- abs(xxx)

source("auxilary_functions.R")
st_shp_path <- "./shapes/"
st_shp_name <- "countries.shp"
st_shp_file <- paste(st_shp_path, st_shp_name, sep="")
# read the shapefile
st_shp <- read_sf(st_shp_file)
st_outline <- as(st_geometry(st_shp), Class="Spatial")

my.at <- seq(-1, 1, length.out = 10)

myTheme <- rasterTheme(region = rev(sequential_hcl(11, "Reds 3")))
plr1 <- levelplot(xxx, at=my.at, par.settings = myTheme, margin=FALSE, main="Gradient-based climate velocity")
plr2 <- plr1 + latticeExtra::layer(sp.lines(st_outline, col="gray30", lwd=1))

jpeg(file="gVoCC_periods.jpg", width=12, height=15, units="in", res=600)
diverge0(plr2, ramp=colorRampPalette(rev(brewer.pal(9,"RdBu"))))
dev.off()

xxx2 <- abs(xxx)
my.at <- seq(0, 1, length.out = 10)
myTheme <- rasterTheme(region = rev(sequential_hcl(11, "Reds 3")))
plr1 <- levelplot(xxx2, at=my.at, par.settings = myTheme, margin=FALSE, main="Gradient-based climate velocity")
plr3 <- plr1 + latticeExtra::layer(sp.lines(st_outline, col="gray30", lwd=1))


jpeg(file="gVoCC_absolute_values_periods.jpg", width=12, height=15, units="in", res=600)
diverge0(plr3, ramp=colorRampPalette(rev(brewer.pal(9,"RdBu"))))
dev.off()


save.image("Mapas_gVoCC_periodos.RData")
