#kmeans


iris_data <- iris[-5]


#kmeans screeplot
wss <- 0
for (k in 1:15) {
  model <- kmeans(iris_data, centers = k, nstart = 20)
  wss[k] <- model$tot.withinss
}

plot(1:15, wss, type="b")


#silhouette analysis
sil <- 0
for (k in 2:15) {
  model <- cluster::pam(iris_data, k=k)
  sil[k] <- model$silinfo$avg.width
}
plot(1:15, sil, type="b")



#kmeans
set.seed(1)
model <- kmeans(iris_data, centers=3, nstart=20)
print(model)

iris$cluster <- model$cluster

library(ggplot2)
ggplot2::ggplot(iris) +
  geom_point(aes(x=Petal.Length, y=Petal.Width, col=as.factor(cluster), shape=Species))



#silhouette
model <- cluster::pam(iris_data, k=3)

iris$silhcluster <- model$clustering
ggplot(iris) +
  geom_point(aes(x=Petal.Length, y=Petal.Width, col=as.factor(silhcluster), shape=Species))
