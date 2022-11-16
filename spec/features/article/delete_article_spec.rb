# frozen_string_literal: true

require 'rails_helper'

describe Article do
  let(:user) { create(:user) }
  let(:article) { create(:article, title: 'Title', body: 'article', user: user) }

  feature 'Delete article' do
    before do
      sign_in user
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
