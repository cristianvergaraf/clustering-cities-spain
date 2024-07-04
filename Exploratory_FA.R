######## Define the parameter lists ###########

### 02.10.2023

## Este script contiene el flujo de trabajo para ejecutar la función search_fa_parameters para realizar
## varios análisis factoriales exportando sus resultados a un excel


library(psych)
library(GPArotation)
library(dplyr)
library(corrplot)

###########################################################################################


# 1- Cargar datos completos 

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")

lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos

lapply(lista_datos,KMO)

fa(lista_datos$df_datos_PTrans.csv,4, rotate = "varimax", fm = "minchi")

completos_PTRANS <- lista_datos$df_datos_PTrans.csv


#################################################################################################

# 2.- Crear distintos set de datos

#  Los set de datos se van a crear eliminando progresivamente variables utilizando como criterio la distribucion original de la variable

#  Que tan alejada de la distribución normal  se encuentra la variable, y el número de outliers que existen 

# Primer intento: Eliminar SQUARE_MN, AREA_AM, DIVISION, Vehiculos, SHAPE_MD, PobH. 

# Finalmente evaluamos el adecuación del dataset para realizar un análisis factorial utilizando 
# el test de Kaiser-Meyer-Olkin. Esta se realaciona a la propoporcion de varianza entre las variables que podria ser 
# varianza común. Mientras más alto el valor, más adecuado el dataset o la variable para realizar un análisis factorial. 


lista_sel_44 <- lapply(lista_datos, dplyr::select, -c("SQUARE_MN","AREA_AM", "DIVISION", "Vehiculos","SHAPE_MD","PobH")) 

lapply(lista_sel_44,KMO)

PTRANS_44 <- lista_sel_44$df_datos_PTrans.csv
NORM_44 <- lista_sel_44$df_datos_Normalizer.csv

########################################################################################################

lista_sel_varios <- lapply(lista_datos, dplyr::select, -c("SQUARE_MN","AREA_AM", "DIVISION", "Vehiculos","SHAPE_MD","PobH","PobM","LPI","SQUARE_MD","FRAC_MD","T_Viv_Prin",
                                                          "T_Viv_Sec","Viv_vacias","MESH","PAFRAC","AREA_MN",)) 
lapply(lista_sel_varios,KMO)

PTRANS32<- lista_sel_varios$df_datos_PTrans.csv
NORM32<- lista_sel_varios$df_datos_Normalizer.csv

#########################################################################


lista_ocio <- lapply(lista_datos, dplyr::select, -c("SQUARE_MN","AREA_AM", "DIVISION", "Vehiculos","SHAPE_MD","PobH","PobM","LPI","SQUARE_MD","FRAC_MD","T_Viv_Prin",

                                                                                                                  "T_Viv_Sec","Viv_vacias","MESH","PAFRAC","AREA_MN","OCIO")) 
Maxabs_ocio <- lista_ocio$df_datos_Maxabs.csv
MinMax_ocio <- lista_ocio$df_datos_MinMax.csv
Norm_ocio <- lista_ocio$df_datos_Normalizer.csv
Ptrans_ocio <- lista_ocio$df_datos_PTrans.csv
Rscaler_ocio <- lista_ocio$df_datos_Rscaler.csv
Std_ocio <- lista_ocio$df_datos_std.csv


#######################################################

lista_sel1 <- lapply(lista_datos, dplyr::select, c("LPI","AREA_MN","AREA_AM","GYRATE_MN","SHEI","NP","DIVISION","SPLIT","SHAPE_MN", "FRAC_MD","IJI","LSI","TE","ED",
                                "RNMDP_2020","PobT","Vehiculos","T_Viviendas","T_Viv_Sec","COM","ED_SING","EQUIP","IND","OCIO","OFI","RES_PLU", "RES_UNI"))
   
lapply(lista_sel1,KMO) 

Norm_sel1 <-  lista_sel1$df_datos_Normalizer.csv
PTrans_sel1 <-  lista_sel1$df_datos_PTrans.csv

################################################################################
################################################################################

lista_sel2 <- lapply(lista_datos, dplyr::select, c("LPI","AREA_MN","GYRATE_MN","SHEI","NP","SPLIT","SHAPE_MN", "FRAC_MD","IJI","LSI","TE","ED",
                                               "RNMDP_2020","PobT","T_Viviendas","T_Viv_Sec","COM","ED_SING","EQUIP","IND","OCIO","OFI","RES_PLU","RES_UNI"))
lapply(lista_sel2,KMO)


Norm_sel2 <- lista_sel2$df_datos_Normalizer.csv
PTrans_sel2 <- lista_sel2$df_datos_PTrans.csv

################################################################################
#################################################################################

lista_sel3 <- lapply(lista_datos, dplyr::select, c("LPI","AREA_MN","GYRATE_MN","SHEI","SPLIT","SHAPE_MN", "FRAC_MD","IJI","LSI","TE","ED",
                                                   "RNMDP_2020","T_Viviendas","COM","ED_SING","EQUIP","IND","OCIO","OFI","RES_PLU","RES_UNI"))
lapply(lista_sel3,KMO)

Norm_sel3 <- lista_sel3$df_datos_Normalizer.csv
PTrans_sel3 <- lista_sel3$df_datos_PTrans.csv

######################################################################################################

lista_sel4 <- lapply(lista_datos, dplyr::select, c("LPI","AREA_MN","GYRATE_MN","SHEI","SPLIT","SHAPE_MN", "FRAC_MD","IJI","LSI","TE","ED",
                                                     "RNMDP_2020","T_Viviendas","COM","ED_SING","EQUIP","IND","OCIO","OFI","RES_PLU"))

lapply(lista_sel4,KMO)

Norm_sel4 <- lista_sel4$df_datos_Normalizer.csv

## Nuevas pruebas de seleccion de variables ####

### 26.06.2023 ###


lista_seleccion_general1 <- lapply(lista_datos, dplyr::select, c("TA","LPI","AREA_MN","AREA_AM","AREA_MD","GYRATE_MN","GYRATE_AM","GYRATE_MD","SHEI","SIDI","SPLIT","MESH","SHAPE_MN", "PAFRAC", "SHAPE_MD","PARA_MN","PARA_MD","FRAC_MD","IJI","LSI","TE","ED",
                                                   "RNMDP_2020","PobT", "Vehiculos", "T_Viv_Prin","T_Viv_Sec", "COM","ED_SING","EQUIP","IND","OCIO","OFI","RES_PLU","RES_UNI"))


lista_seleccion_general <- lapply(lista_datos, dplyr::select, c("TA","LPI","AREA_MN","AREA_AM","AREA_MD","GYRATE_MN","GYRATE_AM","GYRATE_MD","SHEI","SIDI","SPLIT","MESH","SHAPE_MN", "PAFRAC", "SHAPE_MD","PARA_MN","PARA_MD","FRAC_MD","IJI","LSI","TE","ED",
                                                                "RNMDP_2020","PobT", "Vehiculos", "T_Viv_Prin","T_Viv_Sec", "COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))


datos_seleccion_general <- list(lista_seleccion_general$df_datos_Maxabs.csv,lista_seleccion_general$df_datos_MinMax.csv,lista_seleccion_general$df_datos_Normalizer.csv, lista_seleccion_general$df_datos_Normalizer.csv,
                               lista_seleccion_general$df_datos_PTrans.csv, lista_seleccion_general$df_datos_Rscaler.csv, lista_seleccion_general$df_datos_std.csv)

nombres_seleccion_general <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer", "df_datos_Normalizer",
                               "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")



n_factors <- c(3,4,5)
fm_methods <- c("minchi")
#rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")
rotate_methods <- c("promax","oblimin","bentlerQ","geominQ")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_general, nombres_seleccion_general, n_factors, fm_methods, rotate_methods)


#########################################################

### Nuevas pruebas de seleccion de variables ####

### 27.06.2023 ###


### Cargar datos completos ####

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")



lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos


lista_seleccion_1 <- lapply(lista_datos, dplyr::select, c("TA","LPI","AREA_MN","AREA_AM","AREA_MD","GYRATE_MN","GYRATE_AM","GYRATE_MD","SHEI","SIDI","SPLIT","MESH","SHAPE_MN","PAFRAC","SHAPE_MD","FRAC_MD","IJI","LSI","TE","ED",
                                                                 "RNMDP_2020","PobT", "Vehiculos","T_Viv_Prin", "COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))



datos_seleccion_1 <- list(lista_seleccion_1$df_datos_Maxabs.csv,lista_seleccion_1$df_datos_MinMax.csv,lista_seleccion_1$df_datos_Normalizer.csv, lista_seleccion_1$df_datos_Normalizer.csv,
                                lista_seleccion_1$df_datos_PTrans.csv, lista_seleccion_1$df_datos_Rscaler.csv, lista_seleccion_1$df_datos_std.csv)

nombres_seleccion_1 <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer", "df_datos_Normalizer",
                               "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")


n_factors <- c(4,5)
fm_methods <- c("minchi")
rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")
#rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_1, nombres_seleccion_1, n_factors, fm_methods, rotate_methods)


################################################################################################################


# Nuevas pruebas de seleccion de variables 

### 28.06.2023 

## Cargar datos completos 

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")

lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos

lista_seleccion_2 <- lapply(lista_datos, dplyr::select, c("TA","LPI","AREA_MN","AREA_AM","SHEI","SIDI","SPLIT","MESH","DIVISION", "SHAPE_MN","PAFRAC","IJI","LSI","TE","ED",
                                                          "RNMDP_2020","PobT", "Vehiculos","T_Viv_Prin", "COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))



datos_seleccion_2 <- list(lista_seleccion_2$df_datos_Maxabs.csv,lista_seleccion_2$df_datos_MinMax.csv,lista_seleccion_2$df_datos_Normalizer.csv, lista_seleccion_2$df_datos_Normalizer.csv,
                          lista_seleccion_2$df_datos_PTrans.csv, lista_seleccion_2$df_datos_Rscaler.csv, lista_seleccion_2$df_datos_std.csv)

nombres_seleccion_2 <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer", "df_datos_Normalizer",
                         "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")

n_factors <- c(4,5)
fm_methods <- c("minchi")

#rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")

rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_2, nombres_seleccion_2, n_factors, fm_methods, rotate_methods)

################################################################################################################

# Nuevas pruebas de seleccion de variables ####

### 28.06.2023 ###

## Parte II. Seleccion de un menor numero de variables ##

## Cargar datos completos ####

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")

lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos

lista_seleccion_3 <- lapply(lista_datos, dplyr::select, c("TA","AREA_MN","AREA_AM","SIDI","NP","SPLIT","DIVISION", "SHAPE_MN","PAFRAC","IJI","LSI","TE","ED",
                                                          "RNMDP_2020","T_Viviendas", "COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))



datos_seleccion_3 <- list(lista_seleccion_3$df_datos_Maxabs.csv,lista_seleccion_3$df_datos_MinMax.csv,lista_seleccion_3$df_datos_Normalizer.csv, lista_seleccion_3$df_datos_Normalizer.csv,
                          lista_seleccion_3$df_datos_PTrans.csv, lista_seleccion_3$df_datos_Rscaler.csv, lista_seleccion_3$df_datos_std.csv)

nombres_seleccion_3 <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer",
                         "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")

n_factors <- c(5)
fm_methods <- c("minchi")

rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")

#rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_3, nombres_seleccion_3, n_factors, fm_methods, rotate_methods)


##########################################################################################################

# Nuevas pruebas de seleccion de variables ####

## 29.06.2023 ####

## Parte I. Seleccion de un menor numero de variables ##

## Cargar datos completos ####

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")

lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos

lista_seleccion_4 <- lapply(lista_datos, dplyr::select, c("AREA_MN","GYRATE_AM","SIDI","SPLIT","MESH","DIVISION", "SHAPE_MN","PAFRAC","IJI","LSI","ED",
                                                          "RNMDP_2020","T_Viviendas", "COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))



datos_seleccion_4 <- list(lista_seleccion_4$df_datos_Maxabs.csv,lista_seleccion_4$df_datos_MinMax.csv,lista_seleccion_4$df_datos_Normalizer.csv,
                          lista_seleccion_4$df_datos_PTrans.csv, lista_seleccion_4$df_datos_Rscaler.csv, lista_seleccion_4$df_datos_std.csv)

nombres_seleccion_4 <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer",
                         "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")

n_factors <- c(5)
fm_methods <- c("minchi")

#rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")

rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_4, nombres_seleccion_4, n_factors, fm_methods, rotate_methods)


#############################################################################################################################
#############################################################################################################################

## 29.06.2023 ####

## Parte II ##

## Cargar datos completos ####

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")

lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos

lista_seleccion_5 <- lapply(lista_datos, dplyr::select, c("GYRATE_AM","SIDI", "SPLIT","DIVISION", "SHAPE_MN","PAFRAC","IJI","LSI","ED",
                                                          "RNMDP_2020","T_Viviendas", "COM","ED_SING","EQUIP","OFI","RES_PLU","RES_UNI"))


datos_seleccion_5 <- list(lista_seleccion_5$df_datos_Maxabs.csv,lista_seleccion_5$df_datos_MinMax.csv,lista_seleccion_5$df_datos_Normalizer.csv,
                          lista_seleccion_5$df_datos_PTrans.csv, lista_seleccion_5$df_datos_Rscaler.csv, lista_seleccion_5$df_datos_std.csv)

nombres_seleccion_5 <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer",
                         "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")

n_factors <- c(5)
fm_methods <- c("minchi")
#rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")
rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_5, nombres_seleccion_5, n_factors, fm_methods, rotate_methods)

##############################################################################################

##  Analysis 04.07.2023 ####


## Cargar datos completos ####

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")



lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos


lista_seleccion_ohne_AM <- lapply(lista_datos, dplyr::select, c("TA","LPI","AREA_MN","AREA_MD","GYRATE_MN","GYRATE_MD","SHEI","SIDI","SPLIT","MESH","SHAPE_MN","PAFRAC","SHAPE_MD","FRAC_MD","IJI","LSI","TE","ED",
                                                          "RNMDP_2020","PobT", "Vehiculos","T_Viv_Prin", "COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))



datos_seleccion_ohne_AM <- list(lista_seleccion_ohne_AM$df_datos_Maxabs.csv,lista_seleccion_ohne_AM$df_datos_MinMax.csv,lista_seleccion_ohne_AM$df_datos_Normalizer.csv, lista_seleccion_ohne_AM$df_datos_Normalizer.csv,
                          lista_seleccion_ohne_AM$df_datos_PTrans.csv, lista_seleccion_ohne_AM$df_datos_Rscaler.csv, lista_seleccion_ohne_AM$df_datos_std.csv)

nombres_seleccion_ohne_AM <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer", "df_datos_Normalizer",
                         "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")


n_factors <- c(5)
fm_methods <- c("minchi")
rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")

#rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_ohne_AM, nombres_seleccion_ohne_AM, n_factors, fm_methods, rotate_methods)



############################################################################################################

##  Analysis 05.07.2023 ####

## Cargar datos completos ####

setwd("C:/Users/CRISTIAN/github/clustering-metrics/datos/datos_completos")

archivos <- list.files(path = ".", pattern = "*.csv$")



lista_datos <- lapply(archivos, read.csv, fileEncoding = "ISO-8859-1") %>% lapply(dplyr::select, -c("Ciudades","X"))

names(lista_datos) = archivos


lista_seleccion_ohne_AM <- lapply(lista_datos, dplyr::select, c("TA","LPI","AREA_MN","SIDI","SPLIT","MESH","SHAPE_MN","PAFRAC","IJI","LSI","ED",
                                                                "RNMDP_2020","T_Viviendas","COM","ED_SING","EQUIP","IND","OFI","RES_PLU","RES_UNI"))



datos_seleccion_ohne_AM <- list(lista_seleccion_ohne_AM$df_datos_Maxabs.csv,lista_seleccion_ohne_AM$df_datos_MinMax.csv,lista_seleccion_ohne_AM$df_datos_Normalizer.csv, lista_seleccion_ohne_AM$df_datos_Normalizer.csv,
                                lista_seleccion_ohne_AM$df_datos_PTrans.csv, lista_seleccion_ohne_AM$df_datos_Rscaler.csv, lista_seleccion_ohne_AM$df_datos_std.csv)

nombres_seleccion_ohne_AM <- c("df_datos_Maxabs","df_datos_MinMax","df_datos_Normalizer", "df_datos_Normalizer",
                               "df_datos_PTrans", "df_datos_Rscaler", "df_datos_std")


n_factors <- c(5)

fm_methods <- c("minchi")

#rotate_methods <- c("varimax","quartimax","bentlerT","equamax","varimin","geominT")

rotate_methods <- c("varimax","equamax")

#rotate_methods <- c("promax","oblimin")

setwd("C:/Users/CRISTIAN/github/clustering-metrics")

source("function_search_FA_parameters.R")

library(dplyr)

factor_analysis_export(datos_seleccion_ohne_AM, nombres_seleccion_ohne_AM, n_factors, fm_methods, rotate_methods)


