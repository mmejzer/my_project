# frozen_string_literal: true

require 'rails_helper'

describe Article do
  # shared_context 'with authorized user' do
  #   let(:user) { create(:user) }

  #   before do
  #     sign_in user
  #   end
  # end

  # shared_context 'with article' do
  #   let(:article) { create(:article, title: 'Title', body: 'article', user: user) }
  # end

  # feature 'Delete article' do
  #   include_context 'with authorized user'
  #   include_context 'with article'

  #   before do
  #     visit article_path(article)
  #   end

  #   scenario 'as author', js: true do
  #     expect(page).to have_css(".button-delete")
  #     find('button.button-delete').click
  #     # message = page.find(flash[:alert]).native.attribute('validationMessage')
  #     # expect(message).to eq "Are you sure you want to delete the article '#{@article.title}'"
  #     # click_button 'OK'

  #     expect(page).to have_content "Article '#{article.title}' deleted!"
  #   end
  # end
  let(:user) { create(:user) }
  let(:article) { build(:article) }

  context 'when article present' do
    it 'deletes article' do
      article.save

      expect { article.reload }.not_to raise_error
      expect { article.destroy }.to change(described_class, :count).by(-1)
      expect { article.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
