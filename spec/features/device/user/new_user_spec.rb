# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { create(:user, email: 'test@test.ru') }

  feature 'create user' do
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

    scenario 'with not unique email' do
      user
      visit new_user_registration_path
      fill_in 'first_name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'test@test.ru'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign up'
      expect(page).to have_content('Email has already been taken')
    end

    scenario 'with not valid password (short)' do
      visit new_user_registration_path
      fill_in 'first_name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '1'
      fill_in 'Password confirmation', with: '1'
      click_button 'Sign up'
      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end

    scenario 'with not valid confirmation password' do
      visit new_user_registration_path
      fill_in 'first_name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '1123455'
      click_button 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario 'empty first_name, last_name, email and password' do
      visit new_user_registration_path
      click_button 'Sign up'
      expect(page).not_to have_content('Welcome! You have signed up successfully.')
    end
  end
end
