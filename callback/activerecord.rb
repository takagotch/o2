class Subscription < ActiveRecord::Base
  before_create :record_signup

  private
  def record_signup
    self.signed_up_on = Date.today
  end
end

