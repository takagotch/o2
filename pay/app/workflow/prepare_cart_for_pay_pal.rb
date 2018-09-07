class PrepareCartForPayPal < PreparesCart
  attr_accessor :pay_pal_payment

  def update_tickets
    tickets.each(&:pending!)
  end

  def redirect_on_success_url
    pay_pal_payment.redirect_url
  end

  def payment_attributes
    super.merge(payment_method: "paypal")
  end

  def on_failure
    unpurchase_tickets
  end

  def calculate_success
    @success = payment.pending?
  end

  def on_success
    @pay_pal_payment = PayPalPayment.new(payment: payment)
    payment.update!(response_id: pay_pal_payment.response_id)
    payment.pending!
    reverse_purchase if payment.failed?
  end

end


