# coding: utf-8
require 'rserve'

class Recommender
  def initialize
    @conn = Rserve::Connection.new
  end

  def recommend_for(gems)
    input_var_name = gen_input_var_name
    @conn.assign(input_var_name, Rservee::REXP::Wrapper.wrap(gems))
    # TODO call actual R function
    x = @conn.eval("append(#{input_var_name}, c(\"foo\"))")
    x.to_ruby
  end

  private
  def gen_input_var_name
    "input_#{Random.rand(10000000)}"
  end
end
