require 'rails_helper'

RSpec.describe 'Movie index page' do
  it "checks that the API is returning a search result" do
    VCR.use_cassette('search_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      visit "/users/#{user_1.id}/discover"

      fill_in(:keyword, with: "Fight")
      click_button "Find Movies"

      expect(current_path).to eq("/users/#{user_1.id}/movies")
      expect(page).to have_content("Fight Club")
      expect(page).to have_content("Rating: 8.4")

      expect(page).to have_content('Movies with the keyword "Fight"')


      expect(page).not_to have_content("Top Rated Movies")
    end
  end

  it "checks that Find Top Rated Movies button returns a list of top movies" do
    VCR.use_cassette('top_movie_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      visit "/users/#{user_1.id}/discover"

      expect(page).to have_button("Find Top Rated Movies")

      click_button "Find Top Rated Movies"

      expect(current_path).to eq("/users/#{user_1.id}/movies")
      expect(page).to have_content("Your Eyes Tell Rating: 8.8")
      expect(page).to have_link("Your Eyes Tell")
      expect(page).to have_content("Top Rated Movies")

      expect(page).not_to have_content('Movies with the keyword "Fight"')

      click_link "Your Eyes Tell"

      expect(current_path).to eq("/users/#{user_1.id}/movies/730154")

    end
  end

end
