# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  scenario 'log in with valid params' do
    visit new_user_session_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Hello, #{user.first_name} #{user.last_name}")
  end

  scenario 'log in with in valid params' do
    visit new_user_session_url
    fill_in 'Email', with: "#{user.email}11"
    fill_in 'Password', with: "#{user.password}11"
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'log in with empty params' do
    visit new_user_session_url
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).not_to have_content('Signed in successfully.')
  end
end
