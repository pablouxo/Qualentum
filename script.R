# Cargar el dataset nottem
data("nottem")

# Inspeccionar la estructura del dataset
print(class(nottem))  # Verifica que es una serie temporal (ts)
print(summary(nottem))  # Resumen estadístico

# Graficar la serie temporal
plot(nottem, main = "Temperaturas Mensuales en Nottingham (1920-1939)",
     xlab = "Año", ylab = "Temperatura", col = "blue")

# 2. Exploración y preparación de datos

# Descomponer la serie temporal
decomp <- decompose(nottem)

# Visualizar los componentes (tendencia, estacionalidad y aleatoriedad)
plot(decomp)

# 3. Análisis de estacionariedad

# Graficar la autocorrelación (ACF)
acf(nottem, main = "Función de Autocorrelación (ACF)")

# Graficar la autocorrelación parcial (PACF)
pacf(nottem, main = "Función de Autocorrelación Parcial (PACF)")

# Instalar el paquete tseries si no está instalado
if (!require(tseries)) install.packages("tseries", dependencies = TRUE)
library(tseries)

# Prueba de Dickey-Fuller aumentada
adf_test <- adf.test(nottem)
cat("Resultado de la prueba ADF:\n")
print(adf_test)

# 4. Transformación de la serie (si es necesario)

# Si la serie no es estacionaria, realizar diferenciación
if(adf_test$p.value > 0.05) {
  nottem_diff <- diff(nottem)
  plot(nottem_diff, main = "Serie Temporal Diferenciada")
  
  # Volver a realizar la prueba ADF en la serie diferenciada
  adf_test_diff <- adf.test(nottem_diff)
  cat("Resultado de la prueba ADF en la serie diferenciada:\n")
  print(adf_test_diff)
}

# 5. Detección de valores atípicos

# Graficar boxplot para detectar posibles outliers
boxplot(nottem, main = "Boxplot de la Serie Temporal de Temperaturas", ylab = "Temperatura")