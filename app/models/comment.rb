# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  =beginvalidates :commenter, presence: true=end
  validates :body, presence: true
end
