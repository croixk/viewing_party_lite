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

  it 'has a form for new users - authentication' do
    visit register_path
    fill_in("name", with: "name_1")
    fill_in("email", with: "email_1")
    fill_in("username", with: "username_1")
    fill_in("password", with: "password_1")
    click_button "Register"
    expected = User.last
    expect(current_path).to eq("/users/#{expected.id}")
  end



end
