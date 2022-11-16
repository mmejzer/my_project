# frozen_string_literal: true

require 'rails_helper'

describe 'Article' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:article) { create(:article, title: 'Title', body: 'article', user: user) }

  feature 'Show mine article' do
    before do
      sign_in user
      visit article_path(article)
    end

    scenario 'as author' do
      expect(page).to have_content article.title
      expect(page).to have_link(href: "/articles/#{article.id}/edit")
      expect(page).to have_css('.button-delete')
      expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
      expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
      expect(page).to have_content article.title
      expect(page).to have_content article.body
    end
  end

  feature 'Show article' do
    scenario 'as guest' do
      visit article_path(article)
      expect(page).to have_content article.title
      expect(page).not_to have_link(href: "/articles/#{article.id}/edit")
      expect(page).not_to have_css('.button-delete')
      expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
      expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
      expect(page).to have_content article.body
    end
  end

  feature 'Show stranger article' do
    before do
      sign_in user2
      visit article_path(article)
    end

    scenario 'as user not author' do
      expect(page).to have_content article.title
      expect(page).not_to have_link(href: "/articles/#{article.id}/edit")
      expect(page).not_to have_css('.button-delete')
      expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
      expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
      expect(page).to have_content article.body
    end
  end
end
