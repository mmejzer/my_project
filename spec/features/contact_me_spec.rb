# frozen_string_literal: true

require 'rails_helper'

describe '#contact_me' do
  feature 'send message to owner' do
    scenario 'is valid' do
      visit contacts_url
      fill_in 'Name', with: "Test"
      fill_in 'Email', with: "test@test.com"
      fill_in 'Message', with: "Test message"
      click_button 'Send'
      expect(page).to have_content 'Message sent'
    end
  end
end