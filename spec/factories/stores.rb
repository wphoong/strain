FactoryGirl.define do
  factory :store do
    storename 'lul'
    description 'wtf'
    location 'LA'
    phonenumber '123'
    association :user
  end
end
