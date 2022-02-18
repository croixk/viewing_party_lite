require 'rails_helper'

RSpec.describe 'User show page' do

  # before(:each) do
  #   user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
  #
  #   visit login_path
  #
  #   fill_in :username, with: user_1.username
  #   fill_in :password, with: user_1.password
  #
  #   click_on "Log In"
  # end

  it "checks that the users name is on the page " do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

    visit login_path

    fill_in :username, with: user_1.username
    fill_in :password, with: user_1.password

    click_on "Log In"
    # user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
    visit '/dashboard'
    # visit user_path(user_1)

    expect(page).to have_content("#{user_1.name}'s Dashboard")
  end

  it "checks for a button to discover movies " do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

    visit login_path

    fill_in :username, with: user_1.username
    fill_in :password, with: user_1.password

    click_on "Log In"

    # user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

    visit '/dashboard'
    # visit user_path(user_1)

    click_button "Discover Movies"
  end

  it 'has a section to show information for users viewing parties' do
    VCR.use_cassette('user_show_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      visit login_path

      fill_in :username, with: user_1.username
      fill_in :password, with: user_1.password

      click_on "Log In"
      # user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
      party_1 = Party.create!(duration: 120, date: '2022-10-1', start_time: '19:00:00', party_movie_id: 550)

      user_party_11 = UserParty.create!(user_id: user_1.id, party_id: party_1.id, host: true)

      visit '/dashboard'
      # visit user_path(user_1)

      expect(page).to have_content('Viewing parties:')


      expect(page).to have_content(party_1.date)
      expect(page).to have_content("Fight Club")
      expect(page).to have_content(party_1.start_time)
    end
  end

  it 'has a section to show if user is hosting or attending' do
    VCR.use_cassette('user_show_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      visit login_path

      fill_in :username, with: user_1.username
      fill_in :password, with: user_1.password

      click_on "Log In"
      # user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
      party_1 = Party.create!(duration: 120, date: '2022-10-1', start_time: '19:00:00', party_movie_id: 550)

      user_party_11 = UserParty.create!(user_id: user_1.id, party_id: party_1.id, host: true)

      visit '/dashboard'
      # visit user_path(user_1)

      expect(page).to have_content("Hosting")
      expect(page).to_not have_content("Invited")
    end
  end

  it 'has a section to show if user is hosting or attending' do
    VCR.use_cassette('user_show_2_data_from_api') do
      user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      visit login_path

      fill_in :username, with: user_1.username
      fill_in :password, with: user_1.password

      click_on "Log In"
      # user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')

      party_1 = Party.create!(duration: 120, date: '2022-10-1', start_time: '19:00:00', party_movie_id: 550)
      party_2 = Party.create!(duration: 120, date: '2022-10-1', start_time: '19:00:00', party_movie_id: 550)

      user_party_11 = UserParty.create!(user_id: user_1.id, party_id: party_1.id, host: true)
      user_party_12 = UserParty.create!(user_id: user_1.id, party_id: party_2.id, host: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/dashboard'

      expect(page).to have_content("Hosting")

      expect(page).to have_content("Fight Club")

      expect(page).to have_content("Invited")
    end
  end
end
