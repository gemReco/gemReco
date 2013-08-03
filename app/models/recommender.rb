# coding: utf-8
require 'rserve'

class Recommender
  def initialize
    @conn = Rserve::Connection.new
  end

  def recommend_for(gems)
    input_var_name = gen_input_var_name
    @conn.assign(input_var_name, Rserve::REXP::Wrapper.wrap(gems))
    x = @conn.eval("recommend.gem(#{input_var_name})")
    ruby_obj = x.to_ruby || []
    # 値がひとつの時は文字列で返ってくるので配列にする
    if ruby_obj.is_a? String
      [ruby_obj]
    else
      ruby_obj
    end
  end

  private
  def gen_input_var_name
    "input_#{Random.rand(10000000)}"
  end
end
