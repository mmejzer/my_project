# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  it'log out' do
  	sign_in user
  	visit root_url
  	click_link 'Log out'
    expect(page).to have_content('Signed out successfully.')
    expect(page).not_to have_content("Hello, #{user.first_name} #{user.last_name}")
  end
end