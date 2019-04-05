FactoryBot.define do
  factory :currency do
    sequence(:code) { |n| n.to_s }
    name            { "Pounds Sterling" }
    unit            { "£" }
    pre             { true }
    in_euros        { 1.00 }
  end
end
