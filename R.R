df <- read.csv('data/raw_data.csv')
rownames(df) <- df$user_id
df <- df[ , -which(names(df) %in% c("Horodateur", "Quel.est.votre.genre..", "user_id", "Quel.Ã.ge.avez.vous.."))]


df_distance_user <- as.data.frame(as.matrix(dist(df, method = "euclidean", diag = FALSE, upper = FALSE)))

order(df_distance_user[20])[2:6]
