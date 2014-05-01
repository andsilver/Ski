# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flip_key_location do
    rgt 1
    parent_path "MyString"
    parent_id 1
    display "MyString"
    property_count 1
  end
end
