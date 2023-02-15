class MoviesController < ApplicationController
  before_action :validate_user, :find_user

  def index
    @movies = Movie.all
  end 

  def show
    @movie = Movie.find(params[:id])
  end

  private
    def find_user
      @user = User.find(session[:user_id])
    end
end 