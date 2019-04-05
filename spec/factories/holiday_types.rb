# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :holiday_type do
    sequence(:name)            { |n| "Holiday Type #{n}" }
    sequence(:slug)            { |n| "holiday-type-#{n}" }
    sequence(:mega_menu_html)  { |n| "<li><a href='/holiday-type-link#{n}'></a></li>" }
    visible_on_menu { true }
  end
end
