library(arules)
f <- file("./rubygems_2600.csv", "r")
lines <- readLines(con=f)

data.list <- list()
for (i in 1:length(lines)) {
  #読み込んだ行をコンマで分割して、ベクトル化
  line.vec <- strsplit(lines[i], ",")
  data.list <- c(data.list, line.vec)
}
close(f)

#モデル用インプットデータ作成
data.tran <- as(data.list, "transactions")

#アプリオリアルゴリズムでモデルを作成
model.apriori <- apriori(data.tran, parameter = list(supp =0.05,conf=0.2, maxlen=2, minlen=2))

#再利用するためにモデルをdata.frame形式に変換
model.df <- as(model.apriori, "data.frame")

summary(model.df)
write.table(model.df, "model.csv", col.names=F, row.names=F, sep=",")
