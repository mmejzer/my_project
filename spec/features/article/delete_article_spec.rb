# frozen_string_literal: true

require 'rails_helper'

describe Article do
  shared_context 'with authorized user' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end
  end

  shared_context 'with article' do
    let(:article) { create(:article, title: 'Title', body: 'article', user: user) }
  end

  feature 'Delete article' do
    include_context 'with authorized user'
    include_context 'with article'

    before do
      visit article_path(article)
    end

    scenario 'as author', js: true do
      expect(page).to have_css('.button-delete')
      message = accept_alert do
        find('button.button-delete').click
      end
      expect(message).to eq "Are you sure you want to delete the article '#{article.title}'?"
      expect(page).to have_content "Article '#{article.title}' deleted!"
    end
  end
end
