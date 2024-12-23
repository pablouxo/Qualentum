# Paso 1: Cargar librerías y datos
if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")

library(dplyr)
library(tidyr)

# Cargar el dataset mtcars y convertirlo a dataframe
data(mtcars)
df <- as.data.frame(mtcars)

# Paso 2: Selección de columnas y filtrado de filas
df_filtered <- df %>%
  select(mpg, cyl, hp, gear) %>%  # Seleccionar columnas específicas
  filter(cyl > 4)  # Filtrar filas con más de 4 cilindros

# Paso 3: Ordenación y renombrado de columnas
df_sorted <- df_filtered %>%
  arrange(desc(hp)) %>%  # Ordenar por potencia (hp) de forma descendente
  rename(consumo = mpg, potencia = hp)  # Renombrar columnas

# Paso 4: Creación de nuevas columnas y agregación
df_with_efficiency <- df_sorted %>%
  mutate(eficiencia = consumo / potencia)  # Crear columna eficiencia

df_summary <- df_with_efficiency %>%
  group_by(cyl) %>%  # Agrupar por número de cilindros
  summarise(
    consumo_medio = mean(consumo),
    potencia_maxima = max(potencia)
  )

# Paso 5: Creación del segundo dataframe y unión de dataframes
df_transmision <- data.frame(
  gear = c(3, 4, 5),
  tipo_transmision = c("Manual", "Automática", "Semiautomática")
)

df_joined <- left_join(df_with_efficiency, df_transmision, by = "gear")

# Paso 6: Transformación de formatos
# Cambiar a formato largo
df_long <- df_joined %>%
  pivot_longer(
    cols = c(consumo, potencia, eficiencia),
    names_to = "medida",
    values_to = "valor"
  )

# Identificar duplicados antes de transformar de nuevo a formato ancho
df_long_dedup <- df_long %>%
  group_by(cyl, gear, tipo_transmision, medida) %>%
  summarise(valor = mean(valor), .groups = "drop")  # Promedio para duplicados

# Cambiar a formato ancho
df_wide <- df_long_dedup %>%
  pivot_wider(
    names_from = medida,
    values_from = valor
  )

# Paso 7: Verificación (Imprimir resultados)
cat("Filtrado y ordenado:\n")
print(df_sorted)

cat("\nResumen por cilindros:\n")
print(df_summary)

cat("\nUnión con tipo de transmisión:\n")
print(df_joined)

cat("\nFormato largo:\n")
print(df_long)

cat("\nFormato ancho:\n")
print(df_wide)
