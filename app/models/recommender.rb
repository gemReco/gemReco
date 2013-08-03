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
    x.to_ruby
  end

  private
  def gen_input_var_name
    "input_#{Random.rand(10000000)}"
  end
end
