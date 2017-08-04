FactoryGirl.define do
  factory :product do
    strain 'OG'
    straintype 'Sativa'
    effects 'dank'
    description 'Smells like pin'
    association :store
    association :user
  end
end
