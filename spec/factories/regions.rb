FactoryGirl.define do
  factory :region do
    association :country
    name 'Lake Como'
    info 'A popular retreat for aristocrats and wealthy people since Roman times...'
  end
end
