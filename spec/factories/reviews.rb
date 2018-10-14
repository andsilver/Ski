# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    association :property
    rating { 1 }
    title { "MyString" }
    content { "MyText" }
    author_name { "MyString" }
    author_location { "MyString" }
    visited_on { "2018-02-02" }
  end
end
