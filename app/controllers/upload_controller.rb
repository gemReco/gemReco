class UploadController < ApplicationController
  def index
  end

  def create
    gemfile = params[:gemfile]
    return redirect_to :root unless gemfile
    file_contents = gemfile.read
    gems = file_contents.scan(/^\s*gem\s*['"]([^'"]+)['"]/m).flatten
    @recommendations = Recommender.new.recommend_for(gems)
  end
end
