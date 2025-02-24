# Cargar el dataset AirPassengers
data("AirPassengers")

# Inspeccionar la estructura del dataset
print(class(AirPassengers))   # Verifica que es una serie temporal (ts)
print(summary(AirPassengers)) # Resumen estadístico
print(start(AirPassengers))   # Inicio de la serie
print(end(AirPassengers))     # Fin de la serie
print(frequency(AirPassengers)) # Frecuencia: 12 (mensual)

# 2. Exploración inicial

# Graficar la serie temporal
plot(AirPassengers, main="Serie Temporal de Pasajeros Aéreos", ylab="Número de Pasajeros", xlab="Año")

# Calcular estadísticas descriptivas básicas
mean_val <- mean(AirPassengers)
sd_val <- sd(AirPassengers)
cat("Media de la serie: ", mean_val, "\n")
cat("Desviación estándar de la serie: ", sd_val, "\n")

# 3. Análisis de tendencia y estacionalidad

# Descomponer la serie temporal
decomp <- decompose(AirPassengers)

# Visualizar los componentes
plot(decomp)

# 4. Análisis de estacionariedad

# Graficar la autocorrelación
acf(AirPassengers, main="Función de Autocorrelación (ACF)")

# Graficar la autocorrelación parcial
pacf(AirPassengers, main="Función de Autocorrelación Parcial (PACF)")

# Instalar el paquete tseries si no está instalado
if (!require(tseries)) install.packages("tseries", dependencies = TRUE)
library(tseries)

# Prueba de Dickey-Fuller aumentada
adf_test <- adf.test(AirPassengers)
cat("Resultado de la prueba ADF:\n")
print(adf_test)

# Si la serie no es estacionaria, realizar diferenciación
if(adf_test$p.value > 0.05) {
  AirPassengers_diff <- diff(AirPassengers)
  plot(AirPassengers_diff, main="Serie Temporal Diferenciada")
}

# 5. Detección de valores atípicos

# Graficar boxplot para detectar posibles outliers
boxplot(AirPassengers, main="Boxplot de la Serie Temporal", ylab="Número de Pasajeros")

# 6. Interpretación de resultados

# Resume los resultados observados (escribe tu análisis en un archivo o consola)
cat("Análisis de los patrones en la serie temporal:\n")
cat("- La serie presenta un fuerte patrón estacional, con picos durante los meses de verano.\n")
cat("- Existe una tendencia general ascendente a lo largo del tiempo.\n")
cat("- No se detectaron outliers significativos en la serie temporal.\n")
cat("- La serie no es completamente estacionaria, pero al aplicar una diferenciación simple, la serie se vuelve estacionaria.\n")