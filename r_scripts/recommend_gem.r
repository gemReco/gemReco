library(arules)

load("./gemRecoModel.RData")

#存在する条件部だけにフィルタを書けるメソッド
inner.filter.gemlist <- function(gem.list) {
  intersect(itemLabels(lhs(model.apriori)), gem.list)
}

#ルールの右側だけを取り出す関数

extract.rhs <- function(str) {
  result <- unlist(strsplit(str, "=>"))
  result[seq(2, length(result), by=2)]
}

recommend.gem <- function(gem.list) {
  tryCatch({
    inner.recommend.gem(gem.list)
  }, error = function(err){
    list()
  })
}

inner.recommend.gem <- function(gem.list) {
  
  input.list <- inner.filter.gemlist(gem.list)
  result.list <- list()
  
  #ワークスペースに保存されているmodel.aprioriを使用する
  subset.result <- subset(model.apriori, subset = lhs %in% input.list & lift > 2)

  #結果をデータフレーム形式に変換
  model.df <- as(sort(subset.result, by="confidence"), "data.frame")
  
  #結果に追加
  result.list <- c(result.list, extract.rhs(as.character(model.df$rules)))
  
  return (result.list)
}

remove.bracket <- function(str.list) {
  substring(str.list, 2, nchar(str.list)-1)
}
