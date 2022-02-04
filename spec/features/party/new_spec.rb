require 'rails_helper'

RSpec.describe 'User Parties new page' do

  it 'has a form for new user parties/viewing party' do
    VCR.use_cassette('movie_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com')
      user_2 = User.create!(name: 'User 2', email: 'email2@gmail.com')
      user_3 = User.create!(name: 'User 3', email: 'email3@gmail.com')
      visit "/users/#{@user.id}/movies/550}/parties/new"

      fill_in("duration", with: 300)
      fill_in("date", with: "2021-01-01")
      fill_in("start_time", with: "13:00:00")
      fill_in("party_movie_id", with: 550)

      expect(page).to have_content(user_2.email)
      expect(page).to have_content(user_3.email)

      click_button "Create Party"

      expected = Party.last
      expect(current_path).to eq("/users/#{@user.id}")
    end
  end
end
