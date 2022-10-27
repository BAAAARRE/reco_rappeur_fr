# Load data
df_raw <- read.csv('data/raw_data.csv')
rownames(df_raw) <- df_raw$user_id
df <- df_raw[ , -which(names(df_raw) %in% c("Horodateur", "Quel.est.votre.genre..", "user_id", "Quel.Ã.ge.avez.vous.."))]

# Nearest user
df_distance_user <- as.data.frame(as.matrix(dist(df, method = "euclidean", diag = FALSE, upper = FALSE)))

user_id = 20
n_user = 5

order(df_distance_user[user_id])[2:(n_user+1)]


# Reco
df_copy_reco <- df_raw[ , -which(names(df_raw) %in% c("Horodateur", "Quel.est.votre.genre..", "Quel.Ã.ge.avez.vous.."))]
df_copy_reco$favorite_artist <- colnames(df)[apply(df,1,which.max)]


cor_artist <- cor(df)

cor_artist[cor_artist == 1] <- 0
df_artist_and_reco <- data.frame(colnames(cor_artist), colnames(cor_artist)[apply(cor_artist,1,which.max)])
colnames(df_artist_and_reco) <- c('favorite_artist', 'artist_reco')


result_final <- merge(x = df_copy_reco, y = df_artist_and_reco, by = "favorite_artist", all.x = TRUE)
result_final <- result_final[order(result_final$user_id),]
result_final[, which(names(result_final) %in% c("user_id", "favorite_artist", "artist_reco"))]
