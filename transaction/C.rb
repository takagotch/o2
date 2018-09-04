class BasicIncomeAccount < ApplicationRecord
  belongs_to :user

  validates :user_id, presence:true

  validates :account_number, presence: true, uniqueness: true

  validates :balance, presence: true, numericality: {greater_than_or_equal_to: 0.00}

  has_many :withdrawal_account_transactoin, class_name: 'AccountTransaction', :foreign_key => 'withdrawal_account_id'
  has_many :deposit_account_transaction, class_name: 'AccountTransaction', :foreign_key => 'deposit_account_id'
end

