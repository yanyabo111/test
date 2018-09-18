class MovieController < ApplicationController
  def index
    @hottest_movies = Movie.limit(12)
  end

  def detail
    @movie = Movie.find(params[:id])
  end
end
