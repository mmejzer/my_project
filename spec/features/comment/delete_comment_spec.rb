# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  feature 'Delete comment' do
    before do
      sign_in user
      visit article_path(article)
    end

    scenario 'as author', js: true do
      described_class.create(user: user, article: article, body: 'Text comment')
      visit article_path(article)

      element = find('.right-side-buttons')
      expect(element).to have_css('.button-delete')
      message = accept_alert do
        element.find('button.button-delete').click
      end
      expect(message).to eq 'Are you sure?'
      expect(page).to have_content 'Comment deleted!'
    end
  end
end
