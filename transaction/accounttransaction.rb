#Accounttransaction
#DepositAndWithdrawal
#BasicIncomeAccount

begin
  ActiveRecord::Base.transaction {
    Accounttransaction.save!

    if xxx
      raise "[error] rollback!"
    end

    DepositAndWithdrawal.save!
    BasicIncomeAccount.save!
  }
rescue Exception => 3
  #rollback
end


