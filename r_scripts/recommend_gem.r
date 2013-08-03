library(arules)

load("./gemRecoModel.RData")

#ルールの右側だけを取り出す関数

extract.rhs <- function(str) {
  result <- unlist(strsplit(str, "=>"))
  tail(result, n=1)
}

recommend.gem <- function(gem.list) {
  
  test <- gem.list
  result.list <- list()
  
  #ワークスペースに保存されているmodel.aprioriを使用する
  subset.result <- subset(model.apriori, subset = lhs %in% test[1] & lift > 2)

  #結果の上位1件をデータフレーム形式に変換
  model.df <- as(head(sort(subset.result, by="confidence"), n = 1), "data.frame")
  
  #上位1件を結果に追加
  result.list <- c(result.list, extract.rhs(as.character(model.df$rules[1])))
  
  return (result.list)
}

