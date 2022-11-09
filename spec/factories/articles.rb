# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::String.random }
    body  { Faker::String.random }
    status { 'public' }
    user factory: :user
  end
end
