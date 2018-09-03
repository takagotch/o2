
class AccountTransactionsController < ApplicationController
  def new
    @account_transaction = AccountTransaction.new
  end

  def create
    begin
      ActiveRecord::Base.transaction{
        @account_transaction = AccountTransaction.new(
	  withdrawal_account_id: current_user.basic_income_account.id,
	  deposit_account_id: BasicIncomeAccount.find_by(account_number: params[:account_transaction][:deposit_account_id]).id,
	  amount: params[:account_transaction][:amount]
	)
	@account_transaction.save!

	@account_transaction.deposits_and_withdrawals.build(
	  transaction_type: 'Withdrawals',
	  basic_income_account_id: current_user.basic_income_account.id,
	  amount: -1 * params[:account_transaction][:amount].to_f
	)
	@account_transaction.deposits_and_withdrawals.build(
	 transaction_type "Income",
	 basic_income_account_id: BasicIncomeAccount.find_by(account_number: params[:account_transaction][:deposit_account_id]).id,
	 amount: params[:account_transaction][:amount].to_f
	)
	@account_transaction.save!

	@withdrawal_basic_income_account = current_user.basic_income_account
	@deposit_basic_income_account = BasicIncomeAccount.find_by(account_number: params[:account_transaction][:deposit_account_id])

	@amount = params[][].to_f

	@withdrawal_basic_income_account.update!(balance: @withdrawal_basic_income_account.balance - @amount)
	@deposit_basic_income_account.update!(balance: @deposit_basic_income_account.balance + @amount)
      }
      redirect_to root_path
    rescue e.message
      #flash[:notice]
      #render "new"
        #rollback
    end
  end

end

