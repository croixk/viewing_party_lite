require 'rails_helper'

RSpec.describe 'Landing index page' do

  it 'has title of application' do
    visit '/'
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has button to create new user' do
    visit '/'
    click_button 'Create new user'
    expect(current_path).to eq(register_path)
  end

  it 'has button to log in' do
    user = User.create(name: 'name_1', email: 'email_1', username: 'username_1', password: 'password_1')

    visit '/'
    click_button 'Log In'
    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on 'Log In'

    expect(current_path).to eq(root_path)
  end

  it "has list of existing users" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
    user_2 = User.create!(name: 'User 2', email: 'email2@gmail.com', username: 'username_2', password: 'password_2')
    user_3 = User.create!(name: 'User 3', email: 'email3@gmail.com', username: 'username_3', password: 'password_3')
    visit root_path
    expect(page).to have_content("#{user_1.email}'s Dashboard")
    expect(page).to have_content("#{user_2.email}'s Dashboard")
    expect(page).to have_content("#{user_3.email}'s Dashboard")
  end

  it "has list of existing users as links" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com', username: 'username_1', password: 'password_1')
    user_2 = User.create!(name: 'User 2', email: 'email2@gmail.com', username: 'username_2', password: 'password_2')
    user_3 = User.create!(name: 'User 3', email: 'email3@gmail.com', username: 'username_3', password: 'password_3')
    visit root_path
    click_link("#{user_1.email}'s Dashboard")
    expect(current_path).to eq(user_path(user_1))
  end


  it "has link to return to landing page" do
    visit '/'
    click_link 'Home'
    expect(current_path).to eq('/')
  end

end
