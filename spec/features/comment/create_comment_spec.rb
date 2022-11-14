# frozen_string_literal: true

require 'rails_helper'

describe 'Comment' do
  shared_context 'with authorized user' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end
  end

  shared_context 'with no authorized user' do
    let(:user) { create(:user) }
    before do
      sign_out user
    end
  end

  shared_context 'with article' do
    let(:article) { create(:article, user: user) }
  end

  feature 'Create comment' do
    include_context 'with authorized user'
    include_context 'with article'

    before do
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
    include_context 'with article'
    include_context 'with no authorized user'

    scenario 'with no authorized' do
      visit article_path(article)
      expect(page).to have_content 'You must be logged in to leave a comment. Do you want to login/register?'
      expect(page).to have_link('login', href: '/users/sign_in')
      expect(page).to have_link('register', href: '/users/sign_up')
    end
  end
end
