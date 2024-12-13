# Paso 1: Creación de vectores
energia <- c(rep("Renovable", 10), rep("No Renovable", 10))
consumo <- c(25, 30, NA, 35, 40, 28, NA, 50, 45, 55, 60, 65, 70, 75, NA, 80, 85, 90, 95, 100, 105)
costo_kwh <- c(rep(0.15, 10), rep(0.20, 10))  # Precio por kWh para cada tipo de energía

# Paso 2: Limpieza de datos - Reemplazo de valores NA por la mediana
# Calcular la mediana de consumo por tipo de energía
mediana_renovable <- median(consumo[energia == "Renovable"], na.rm = TRUE)
mediana_no_renovable <- median(consumo[energia == "No Renovable"], na.rm = TRUE)

# Reemplazar NA por la mediana correspondiente
consumo[energia == "Renovable" & is.na(consumo)] <- mediana_renovable
consumo[energia == "No Renovable" & is.na(consumo)] <- mediana_no_renovable

# Paso 3: Creación del dataframe
df_consumo <- data.frame(energia, consumo, costo_kwh)

# Paso 4: Cálculos
# Agregar la columna costo_total
df_consumo$costo_total <- df_consumo$consumo * df_consumo$costo_kwh

# Calcular el total de consumo y el costo total por tipo de energía
total_consumo <- tapply(df_consumo$consumo, df_consumo$energia, sum)
total_costo <- tapply(df_consumo$costo_total, df_consumo$energia, sum)

# Calcular la media de consumo por tipo de energía
media_consumo <- tapply(df_consumo$consumo, df_consumo$energia, mean)

# Agregar la columna ganancia (10% de aumento en el costo)
df_consumo$ganancia <- df_consumo$costo_total * 1.1

# Paso 5: Resumen
# Ordenar el dataframe por costo_total de manera descendente
df_consumo_ordenado <- df_consumo[order(df_consumo$costo_total, decreasing = TRUE), ]

# Extraer las tres filas con el mayor costo_total
top_3_costos <- head(df_consumo_ordenado, 3)

# Crear la lista resumen_energia
resumen_energia <- list(
  dataframe_ordenado = df_consumo_ordenado,
  total_consumo = total_consumo,
  total_costo = total_costo,
  top_3_costos = top_3_costos
)

# Mostrar el resumen
print(resumen_energia)