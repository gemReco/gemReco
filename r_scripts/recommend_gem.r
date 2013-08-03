library(arules)

load("./gemRecoModel.RData")

#存在する条件部だけにフィルタを書けるメソッド
inner.filter.gemlist <- function(gem.list) {
  intersect(itemLabels(lhs(model.apriori)), gem.list)
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
  #ワークスペースに保存されているmodel.aprioriを使用する
  subset.result <- subset(model.apriori, subset = lhs %in% input.list & lift > 2)
  result_gems <- labels(rhs(sort(subset.result, by="confidence")))[[2]]
  setdiff(remove.bracket(unique(result_gems)), gem.list)
}

remove.bracket <- function(str.list) {
  substring(str.list, 2, nchar(str.list)-1)
}
