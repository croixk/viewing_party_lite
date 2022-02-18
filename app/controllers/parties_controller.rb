class PartiesController < ApplicationController
  # GET /parties or /parties.json


  # GET /parties/1 or /parties/1.json
  def show
  end

  def new
    @user = User.find_by(id: session[:user_id])
    @users = User.all
    @movie_id = params[:movie_id]
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = ENV['movies_api_key']
    end
    # response = conn.get("/3/search/movie?api_key=#{conn.params[:api_key]}&query=#{@query}")

    movie_id_response = conn.get("/3/movie/#{@movie_id}")
    @movie = JSON.parse(movie_id_response.body, symbolize_names: true)
  end

  def create
    @user = User.find_by(id: session[:user_id])

    @party = @user.parties.create!(party_params)

    @user_party = @party.user_parties.update(host: params[:host])

    @user.save

    redirect_to "/dashboard"

  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a list of trusted parameters through.
    def party_params
      params.permit(:duration, :date, :start_time, :party_movie_id)
    end
end
