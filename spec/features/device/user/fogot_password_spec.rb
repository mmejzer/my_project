# frozen_string_literal: true

require 'rails_helper'

describe 'fogot password' do
  let(:user) { create(:user) }

  scenario 'with valid email and password' do
    visit new_user_password_path
    fill_in 'Email', with: user.email
    click_button 'Send me reset password instructions'

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'

    open_email(user.email)
    current_email.click_on 'Change my password'

    fill_in 'New password', with: 'password'
    fill_in 'Confirm new password', with: 'password'
    click_button 'Change my password'

    expect(page).to have_content 'Your password has been changed successfully. You are now signed in.'
  end

  scenario 'with valid email, invalid password and confirm password' do
    visit new_user_password_path
    fill_in 'Email', with: user.email
    click_button 'Send me reset password instructions'

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'

    open_email(user.email)
    current_email.click_on 'Change my password'

    fill_in 'New password', with: '12'
    fill_in 'Confirm new password', with: '1'
    click_button 'Change my password'

    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(page).to have_content 'Password is too short (minimum is 6 characters)'
  end

  scenario 'with not registred email' do
    visit new_user_password_path
    fill_in 'Email', with: "#{user.email}11"
    click_button 'Send me reset password instructions'

    expect(page).to have_content 'Email not found'
    expect(page).not_to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end

  scenario 'with empty email' do
    visit new_user_password_path
    fill_in 'Email', with: ''
    click_button 'Send me reset password instructions'

    expect(page).to have_content 'Forgot your password?'
    expect(page).not_to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
  end
end
