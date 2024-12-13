# Función para leer los números desde el archivo
leer_numeros <- function(archivo) {
  # Verificar si el archivo existe
  if (!file.exists(archivo)) {
    stop("El archivo no existe. Deteniendo ejecución.")
  }
  # Leer los números del archivo y convertirlos en un vector de enteros
  numeros <- as.integer(readLines(archivo))
  return(numeros)
}

# Función para calcular los estadísticos (media, mediana, desviación estándar)
calcular_estadisticos <- function(numeros) {
  media <- mean(numeros)
  mediana <- median(numeros)
  desviacion_estandar <- sd(numeros)
  return(list(media = media, mediana = mediana, desviacion_estandar = desviacion_estandar))
}

# Función para calcular el cuadrado de cada número usando sapply
calcular_cuadrados <- function(numeros) {
  cuadrados <- sapply(numeros, function(x) x^2)
  return(cuadrados)
}

# Función para generar el archivo de resultados
guardar_resultados <- function(estadisticos, cuadrados, archivo_salida) {
  # Abrir el archivo para escribir
  salida <- file(archivo_salida, "w")
  
  # Escribir los estadísticos
  writeLines(paste("Media:", estadisticos$media), salida)
  writeLines(paste("Mediana:", estadisticos$mediana), salida)
  writeLines(paste("Desviación estándar:", estadisticos$desviacion_estandar), salida)
  
  # Verificar si la desviación estándar es mayor a 10
  if (estadisticos$desviacion_estandar > 10) {
    writeLines("¡Alta variabilidad en los datos!", salida)
  }
  
  # Escribir los cuadrados de los números
  writeLines("Cuadrados de los números:", salida)
  writeLines(paste(cuadrados, collapse = ", "), salida)
  
  # Cerrar el archivo
  close(salida)
}

# Función principal que coordina todo el proceso
procesar_datos <- function(archivo_entrada, archivo_salida) {
  # Paso 1: Leer los números desde el archivo
  numeros <- leer_numeros(archivo_entrada)
  
  # Paso 2: Calcular los estadísticos
  estadisticos <- calcular_estadisticos(numeros)
  
  # Paso 3: Calcular los cuadrados de los números
  cuadrados <- calcular_cuadrados(numeros)
  
  # Paso 4: Guardar los resultados en un archivo
  guardar_resultados(estadisticos, cuadrados, archivo_salida)
}

# Ejecutar el proceso
procesar_datos("numeros.txt", "resultados.txt")
