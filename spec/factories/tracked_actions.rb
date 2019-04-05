# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :tracked_actions do
    remote_ip { "MyString" }
    trackable_id { 1 }
    action { 1 }
    http_user_agent { "MyString" }
  end
end
