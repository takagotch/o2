FactoryGirl.define do
  factory :discount_code do
    code "MyString"
    percentage 1
    description "MyString"
    minimum_amount nil
    maximum_discount nil
    max_uses 1
  end
end

