FactoryGirl.define do
  factory :user do
    name "Test User"
    email { |n| "test_#{n}@ex.com" }
    password "please123"
  end

end

