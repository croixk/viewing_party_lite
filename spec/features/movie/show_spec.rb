require 'rails_helper'

RSpec.describe 'Movie show page' do
  it "has link for movie, takes to movie show page" do
    VCR.use_cassette('movie_show_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      visit "/users/#{user_1.id}/discover"

      fill_in(:keyword, with: "Fight")
      click_button "Find Movies"

      click_link("Fight Club")
      expect(current_path).to eq("/users/#{user_1.id}/movies/550")

    end
  end

  it "has movie attributes" do
    VCR.use_cassette('movie_show_2_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
      visit "/users/#{user_1.id}/discover"

      fill_in(:keyword, with: "Fight")
      click_button "Find Movies"

      click_link("Fight Club")
      expect(current_path).to eq("/users/#{user_1.id}/movies/550")

      expect(page).to have_content("Fight Club")
      expect(page).to have_content("8.4")
      expect(page).to have_content("139")
      expect(page).to have_content("Drama")
      expect(page).to have_content("A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
      expect(page).to have_content("Cast:\nEdward Norton as The Narrator\nBrad Pitt as Tyler Durden\nHelena Bonham Carter as Marla Singer\nMeat Loaf as Robert \"Bob\" Paulson\nJared Leto as Angel Face\nZach Grenier as Richard Chesler\nHolt McCallany as The Mechanic\nEion Bailey as Ricky\nRichmond Arquette as Intern\nDavid Andrews as Thomas\nChristina Cabot as Group Leader")
      expect(page).to have_content("5 Reviews")
      expect(page).to have_content("Goddard")
      expect(page).to have_content("Pretty awesome movie. It shows what one crazy person can convince other crazy people to do. Everyone needs something to believe in. I recommend Jesus Christ, but they want Tyler Durden.")
    end
  end

  it "has a return to discover index page button" do
    VCR.use_cassette('movie_data_3_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
      visit "/users/#{user_1.id}/movies/550"
      expect(page).to have_button("Discover Page")

      click_button "Discover Page"
      expect(current_path).to eq("/users/#{user_1.id}/discover")
    end
  end

  it "has a button to create a viewing party" do
    VCR.use_cassette('movie_show_4_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
      visit "/users/#{user_1.id}/movies/550"

      expect(page).to have_button("Create Viewing Party")

      click_button "Create Viewing Party"

      expect(current_path).to eq("/users/#{user_1.id}/movies/550/parties/new")
    end
  end
end
