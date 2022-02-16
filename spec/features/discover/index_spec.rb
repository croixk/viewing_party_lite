require 'rails_helper'

RSpec.describe 'Discover index page' do
  it "checks for description of page" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
    visit "/users/#{user_1.id}/discover"
    expect(page).to have_content("Discover Movies")
  end

  it "check for top rated movies button" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
    visit "/users/#{user_1.id}/discover"
    expect(page).to have_button("Find Top Rated Movies")
  end
end
