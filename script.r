---
title: "Análisis Exploratorio de Datos: mtcars"
author: "Tu Nombre"
date: "`r Sys.Date()`"
output:
  html_document:
    theme: readable
    toc: true
    toc_depth: 2
    toc_float: true
---

```{r setup, include=FALSE}
# Configuración inicial
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)
library(tidyverse)
library(knitr)
library(DT)
```

# Introducción

El objetivo de este informe es realizar un análisis exploratorio del conjunto de datos **mtcars**, que contiene información sobre el rendimiento y características de automóviles. Este análisis incluye:

- Presentación del conjunto de datos mediante tablas (estática e interactiva).
- Visualización gráfica de relaciones entre variables clave.
- Resumen de hallazgos principales.

El informe está estructurado de la siguiente manera:
1. **Análisis de datos**: Presentación y exploración de los datos.
2. **Conclusiones**: Resumen de los puntos clave observados.

---

# Análisis de Datos

## Carga del Conjunto de Datos

```{r cargar_datos}
# Cargar el conjunto de datos mtcars
datos <- mtcars
# Añadir una columna de nombres de los automóviles
datos <- datos %>% rownames_to_column("Modelo")
```

## Exploración Inicial

### Tabla Estática

A continuación, se presentan las primeras filas del conjunto de datos utilizando una tabla estática:

```{r tabla_estatica}
# Crear tabla estática con kable
kable(head(datos), caption = "Primeras filas del conjunto de datos mtcars")
```

### Tabla Interactiva

La tabla interactiva permite explorar el conjunto de datos completo:

```{r tabla_interactiva}
# Crear tabla interactiva con DT
datatable(datos, options = list(pageLength = 10), caption = "Conjunto de datos mtcars completo")
```

## Visualización Gráfica

A continuación, se presenta un gráfico de dispersión que analiza la relación entre el consumo de combustible (mpg) y el peso (wt) de los automóviles:

```{r grafico_dispersion}
# Crear gráfico de dispersión
ggplot(datos, aes(x = wt, y = mpg)) +
  geom_point(color = "blue", size = 3) +
  labs(
    title = "Relación entre Peso y Consumo de Combustible",
    x = "Peso (wt)",
    y = "Consumo de Combustible (mpg)"
  ) +
  theme_minimal()
```

---

# Conclusiones

De este análisis se pueden extraer las siguientes conclusiones principales:

1. **Peso y consumo de combustible**: Existe una relación negativa entre el peso de un automóvil y su consumo de combustible. Los automóviles más pesados tienden a tener un menor consumo (mpg).
2. **Exploración interactiva**: La tabla interactiva facilita la inspección detallada de las características de cada modelo de automóvil.
3. **Visualización**: Los gráficos son herramientas útiles para identificar patrones en los datos.

Este análisis exploratorio proporciona una visión inicial de los datos de `mtcars`, lo que permite profundizar en estudios más avanzados o específicos en el futuro.

---
