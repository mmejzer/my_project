require 'rails_helper'

RSpec.describe 'create user', type: :system do
  scenario 'empty first_name, last_name, email and password' do
    visit new_user_registration_path
    click_button 'Sign up'
    expect(page).to have_content("5 errors prohibited this user from being saved")
  end

  scenario 'valid' do
    visit new_user_registration_path
    fill_in 'First name', with: 'Mark'
    fill_in 'Last name', with: 'Black'
    fill_in 'Email', with: 'Black@gmail.com'
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end