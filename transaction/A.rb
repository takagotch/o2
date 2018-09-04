class AccountTransaction < ApplicationRecord
  belongs_to :withdrawal, class_name: 'BasicIncomeAccount', :foreign_key => 'withdrawal_account_id'
  belongs_to :deposit, class_name: 'BasicIncomeAccount', :foreign_key => 'deposit_account_id'

  validates :withdrawal_account_id, presence:true

  validates :deposit_account_id, presence:true

  validates :amount, presence: true, numericality: true

  has_many :deposits_and_withdrawals
end

