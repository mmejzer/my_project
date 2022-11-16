# frozen_string_literal: true

require 'rails_helper'

describe 'Comment' do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  feature 'Create comment' do
    before do
      sign_in user
      visit article_path(article)
    end

    scenario 'with valid attributes as authorized user' do
      fill_in 'Body', with: 'Test comment text'
      click_button 'Create Comment'

      expect(page).to have_content 'Your comment was posted'
      expect(page).to have_content "#{user.first_name} #{user.last_name}"
      expect(page).to have_content 'Test comment text'
    end

    scenario 'with not valid attributes' do
      fill_in 'Body', with: ''
      click_button 'Create Comment'

      expect(page).not_to have_content 'Your comment was posted'
    end
  end

  feature 'Create article' do
    before do
      sign_out user
      visit article_path(article)
    end

    scenario 'with no authorized' do
      expect(page).to have_content 'You must be logged in to leave a comment. Do you want to login/register?'
      expect(page).to have_link('login', href: '/users/sign_in')
      expect(page).to have_link('register', href: '/users/sign_up')
    end
  end
end
