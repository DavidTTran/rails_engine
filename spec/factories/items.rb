FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { 1.5 }
    updated_at { "MyString" }
    created_at { "MyString" }
    merchant_id {  }
  end

  factory :post do
    association :item
  end
end
