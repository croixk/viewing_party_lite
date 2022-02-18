require 'rails_helper'

RSpec.describe 'User new page' do

  # it 'has a form for new users' do
  #   visit register_path
  #   fill_in("Name", with: "Name_1")
  #   fill_in("Email", with: "Name_1@email.com")
  #   click_button "Register"
  #   expected = User.last
  #   expect(current_path).to eq("/users/#{expected.id}")
  # end
  describe 'happy path' do
    it 'has a form for new users - authentication' do
      visit register_path
      fill_in("name", with: "name_1")
      fill_in("email", with: "email_1")
      fill_in("username", with: "username_1")
      fill_in("password", with: "password_1")
      fill_in("password_confirmation", with: "password_1")
      click_button "Register"
      expected = User.last
      expect(current_path).to eq("/dashboard")
    end
  end

  describe 'sad path' do
    it 'has a flash message to check that password, password confirmation both arrived and match' do
      visit register_path
      fill_in("name", with: "name_1")
      fill_in("email", with: "email_1")
      fill_in("username", with: "username_1")
      fill_in("password", with: "password_1")
      fill_in("password_confirmation", with: "")
      click_button "Register"
      expect(flash[:password]).to eq("Passwords must match and not be empty")
      ### how to test for flash message?
    end
  end
end
