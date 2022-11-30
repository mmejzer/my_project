# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Title article test' }
    body  { 'Body article test' }
    status { 'public' }
    user factory: :user
  end
end
