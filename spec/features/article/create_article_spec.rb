# frozen_string_literal: true

require 'rails_helper'

describe 'Article' do
  let(:user) { create(:user) }

  feature 'Create article when authorized user ' do
    before do
      sign_in user
      visit new_article_path
    end

    scenario 'with valid attributes' do
      fill_in 'Title', with: 'Title'
      fill_in 'Body', with: 'article'
      click_button 'Create Article'

      expect(page).to have_current_path "/articles/#{Article.last.id}"
      expect(page).to have_content 'Your article was created'
      expect(page).to have_content 'Title'
      expect(page).to have_content 'article'
      expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
      expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
    end

    scenario 'with not valid attributes' do
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''
      click_button 'Create Article'

      expect(page).not_to have_content 'Your article was created'
    end
  end

  feature 'Create article' do
    scenario 'when no authorized user' do
      visit new_article_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
