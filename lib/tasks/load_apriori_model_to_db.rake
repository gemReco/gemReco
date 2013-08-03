# coding : utf-8
require "csv"

desc "model.csvからデータを読み込んで、DBに情報を突っ込む"
task :load_apriori_model_to_db => :environment do

  Apriori.transaction do
    #model.csvの読み込み
    CSV.foreach("#{Rails.root}/r_scripts/model.csv") do |row|

      #CSVの行の読み込み
      apriori = Apriori.new

      #{hoge} => {moge}のような形式で保存されているルールをDB用に分解する
      #まずは、=>で分解する
      split_rules = row[0].split("=>")

      apriori.lhs = split_rules[0].strip.slice(1,split_rules[0].length-1)
      apriori.rhs = split_rules[1].strip.slice(1,split_rules[1].length-1)

      #指標の設定
      apriori.support = row[1]
      apriori.confidence = row[2]
      apriori.lift = row[3]

      #保存
      apriori.save
    end
  end

  puts "done."
end

