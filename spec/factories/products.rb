FactoryGirl.define do
  factory :product do
    strain 'OG'
    type 'Sativa'
    effect 'dank'
    description 'Smells like pin'
    association :store
  end
end
