FactoryGirl.define do
  factory :subscription do
    user nil
    plan nil
    start_date "2018-09-09"
    end_date "2018-09-09"
    payment_method "MyString"
    remote_id "MyString"
    string "MyString"
  end

end

