FactoryBot.define do
  factory :currency do
    code     { 'GBP' }
    name     { 'GBP' }
    unit     { '£' }
    pre      { true }
    in_euros { 0.89 }
  end
end
