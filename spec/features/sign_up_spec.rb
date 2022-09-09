# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'create user', js: true do
  scenario 'empty first_name, last_name, email and password' do
    visit new_user_registration_path
    click_button 'Sign up'

    message = page.find("#first_name").native.attribute("validationMessage")
    expect(message).to eq "Please fill out this field."

    # expect(page).not_to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'with valid params' do
    visit new_user_registration_path
    fill_in 'first_name', with: Faker::Name.first_name
    fill_in 'Last name', with: Faker::Name.last_name
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
