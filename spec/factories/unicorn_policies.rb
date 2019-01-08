FactoryBot.define do
  factory :unicorn_policy do
    type { 'LIBR' }
    policy_num { 1 }
    name { 'GREEN' }
    description { '' }
    shadowed { '' }
    destination { '' }
  end
end
