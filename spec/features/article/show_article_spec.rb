# frozen_string_literal: true

require 'rails_helper'

describe 'Article' do
  shared_context 'with authorized user' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end
  end

  shared_context 'with authorized user2' do
    let(:user2) { create(:user) }

    before do
      sign_in user2
    end
  end

  shared_context 'with no authorized user' do
    let(:user) { create(:user) }
    before do
      sign_out user
    end
  end

  shared_context 'with article' do
    let(:article) { create(:article, title: 'Title', body: 'article', user: user) }
  end

  feature 'Show article' do
    include_context 'with authorized user'
    include_context 'with article'

    before do
      visit article_path(article)
    end

    scenario 'as author' do
      expect(page).to have_content article.title
      expect(page).to have_link(href: "/articles/#{article.id}/edit")
      expect(page).to have_css('.button-delete')
      expect(page).to have_content article.body
    end
  end

  # feature 'Show article' do
  #   include_context 'with article'
  #   include_context 'with no authorized user'

  #   scenario 'as guest' do
  #     visit article_path(article)
  #     expect(page).to have_content article.title
  #     expect(page).not_to  have_link(href: "/articles/#{article.id}/edit")
  #     expect(page).not_to have_css(".button-delete")
  #     expect(page).to have_content article.body
  #   end
  # end

  # feature 'Show article' do
  #   include_context 'with authorized user'
  #   include_context 'with article'
  #   include_context 'with authorized user2'

  #   scenario 'as authorized user not author' do
  #     visit article_path(article)
  #     expect(page).to have_content article.title
  #     expect(page).not_to  have_link(href: "/articles/#{article.id}/edit")
  #     expect(page).not_to have_css(".button-delete")
  #     expect(page).to have_content article.body
  #   end
  # end
end
