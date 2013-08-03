
library(arules)
f <- file("./rubygems_500.csv", "r")
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
model.apriori <- apriori(data.tran)

#再利用するためにモデルをdata.frame形式に変換
model.df <- as(model.apriori, "data.frame")

summary(model.df)

#作ったモデルごとワークスペースに保存
save.image("./gemRecoModel.RData")
