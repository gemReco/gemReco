class UploadController < ApplicationController
  def index
  end

  def create
    gemfile = params[:gemfile]
    return redirect_to :root unless gemfile
    file_contents = gemfile.read
    # process file_contents here to get @recommendations
    @recommendations = %w(rails sqlite3 sass-rails)
  end
end
