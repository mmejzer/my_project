# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { create(:user, password: 'password') }
  let(:user2) { create(:user, email: 'test@test.ru') }

  feature 'edit user' do
    before do
      sign_in user
      visit edit_user_registration_path(user)
    end

    scenario 'with valid params and change password' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      fill_in 'Current password', with: 'password'
      click_button 'Update'
      expect(page).to have_content('Your account has been updated successfully.')
    end

    scenario 'with valid params and not change password' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Current password', with: 'password'
      click_button 'Update'
      expect(page).to have_content('Your account has been updated successfully.')
    end

    scenario 'with not unique email' do
      user2
      fill_in 'Email', with: 'test@test.ru'
      fill_in 'Current password', with: 'password'
      click_button 'Update'
      expect(page).to have_content('Email has already been taken')
    end

    scenario 'empty first_name, last_name, email and password' do
      click_button 'Update'
      expect(page).not_to have_content('Your account has been updated successfully.')
    end
  end
end
