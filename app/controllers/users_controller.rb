class UsersController < ApplicationController


  def show
     @user = User.find(params[:id])
     @movies = []
     @user.parties.each do |party|

       conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
         faraday.params[:api_key] = ENV['movies_api_key']
       end
       # response = conn.get("/3/search/movie?api_key=#{conn.params[:api_key]}&query=#{@query}")

       movie_id_response = conn.get("/3/movie/#{party.party_movie_id}")
       @movie = JSON.parse(movie_id_response.body, symbolize_names: true)
       @movies.push(@movie)
    end

  end

  def new

  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.permit(:name, :email, :username, :password)
  end
end
