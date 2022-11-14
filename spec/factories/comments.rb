# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body  { 'Body comment test' }
    user factory: :user
    article factory: :article
  end
end
