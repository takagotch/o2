class BankAccount < ActiveRecord::Base
  before_save      EncryptionWrapper.new("credit_card_number")
  after_save       EncryptionWrapper.new("credit_card_number")
  after_initialize EncrytionWrapper.new("credit_card_number")
end

class EncryptionWrapper
  def initialize(attribute)
    @attribute = attribute
  end

  def before_save(record)
    record.send("#{@attribute}=", encrypt(record.send("#{@attribute}")))
  end

  def after_save(record)
    record.send("#{@attribute}=", encrypt(record.send("#{@attribute}")))
  end

  alias_method :after_initialize, :after_save

  private
  def encrypt(value)
  end

  def decrypt(value)
  end
end



