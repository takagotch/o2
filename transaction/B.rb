class DepositsAndWithdrawal < ApplicationRecord
  belongs_to :account_transaction

  validates :account_transaction_id, presence:true

  validates :amount, presence: true, numericality: true

  belongs_to :basic_income_account
end

