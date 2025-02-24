# Cargar las librerías necesarias
library(ggplot2)
library(cluster)

# 1. Carga del dataset
dataset <- read.csv("Mall_Customers.csv")
head(dataset)

# 2. Exploración y limpieza de datos
# Examinar las dimensiones y características
dim(dataset)
str(dataset)
summary(dataset)

# Renombrar las columnas para facilitar su manejo
colnames(dataset) <- c("CustomerID", "Gender", "Age", "AnnualIncome", "SpendingScore")

# Codificar la variable 'Gender' como numérica (1 para masculino, 0 para femenino)
dataset$Gender <- ifelse(dataset$Gender == "Male", 1, 0)

# Normalizar las variables 'AnnualIncome' y 'SpendingScore'
dataset$AnnualIncome <- scale(dataset$AnnualIncome)
dataset$SpendingScore <- scale(dataset$SpendingScore)

# 3. Exploración de variables
# Visualización de la distribución de la variable 'Age'
ggplot(dataset, aes(x=Age)) + 
  geom_histogram(binwidth=5, fill="blue", color="black", alpha=0.7) +
  labs(title="Distribución de Edad", x="Edad", y="Frecuencia")

# 4. Entrenamiento de modelos de clustering

## K-Means
# Calcular la suma de cuadrados interna (tot.withinss) para diferentes números de clusters
wss <- numeric(6)
for(i in 2:6) {
  kmeans_model <- kmeans(dataset[, c("AnnualIncome", "SpendingScore")], centers = i)
  wss[i] <- kmeans_model$tot.withinss
}

# Graficar el método del codo para determinar el número óptimo de clusters
plot(2:6, wss[2:6], type="b", xlab="Número de clusters", ylab="Suma de cuadrados interna")

# Entrenar el modelo K-Means con el número óptimo de clusters (por ejemplo, 4)
kmeans_model <- kmeans(dataset[, c("AnnualIncome", "SpendingScore")], centers = 4)
dataset$KMeansCluster <- kmeans_model$cluster

## Clustering Jerárquico
# Calcular una matriz de distancias
dist_matrix <- dist(dataset[, c("AnnualIncome", "SpendingScore")], method = "euclidean")

# Aplicar el método ward.D para generar un dendrograma
hc <- hclust(dist_matrix, method = "ward.D")
plot(hc)

# Cortar el dendrograma en 4 clusters
clusters_hc <- cutree(hc, k=4)
dataset$HCCluster <- clusters_hc

# 5. Evaluación de modelos usando la métrica de silueta
silhouette_kmeans <- silhouette(kmeans_model$cluster, dist_matrix)
silhouette_hc <- silhouette(clusters_hc, dist_matrix)

# Promedio de silueta para cada modelo
mean(silhouette_kmeans[, 3])  # Promedio de silueta para K-Means
mean(silhouette_hc[, 3])      # Promedio de silueta para jerárquico

# 6. Análisis descriptivo de segmentos
# Estadísticas descriptivas por cluster K-Means
aggregate(cbind(Age, AnnualIncome, SpendingScore) ~ KMeansCluster, data = dataset, mean)

# Estadísticas descriptivas por cluster jerárquico
aggregate(cbind(Age, AnnualIncome, SpendingScore) ~ HCCluster, data = dataset, mean)

# 7. Visualización de los resultados
# Gráfico de dispersión de los clusters generados por K-Means
ggplot(dataset, aes(x = AnnualIncome, y = SpendingScore, color = factor(KMeansCluster))) +
  geom_point() +
  labs(title = "Clusters generados por K-Means", x = "Ingreso Anual", y = "Puntuación de Gasto")

# Gráfico de dispersión de los clusters generados por Clustering Jerárquico
ggplot(dataset, aes(x = AnnualIncome, y = SpendingScore, color = factor(HCCluster))) +
  geom_point() +
  labs(title = "Clusters generados por Clustering Jerárquico", x = "Ingreso Anual", y = "Puntuación de Gasto")
