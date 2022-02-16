require 'rails_helper'

RSpec.describe MovieFacade do
  it '.movies_searched' do
    VCR.use_cassette('search_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      movies = MovieFacade.movies_searched("Fight")

      expect(movies).to be_a Array
      movies.each do |movie|
        expect(movie).to be_a MovieResults
      end
    end
  end

  it '.top movies' do
    VCR.use_cassette('top_movie_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      movies = MovieFacade.top_movies

      expect(movies).to be_a Array
      movies.each do |movie|
        expect(movie).to be_a MovieResults
      end
    end
  end
end
