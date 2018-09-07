class PreparesCartForStripe < PreparesCart
  attr_accessor :stripe_token, :stripe_charge

  def initialize(user:, stripe_token:, purchase_amount_cents:,
		expected_ticket_ids:, payment_reference: nil, discount_code_string: nil)
	  super(user: user, purchase_amount_cents: purchase_amount_cents,
	       expected_ticket_ids:expected_ticket_ids,
	       payment_reference: payment_reference,
	       discount_code_string: discount_code_string)
	  @stripe_token = stripe_token
  end

  def update_tickets
    tickets.each(&:purchased!)
  end

  def on_success
    ExecutesStripePurchaseJob.perform_later(payment, stripe_token.id)
  end

  def on_failure
    unpurchase_tickets
  end

  def unpurchase_tickets
    tickets.each(&:waiting!)
  end

  def payment_attributes
    super.merge(payment_method: "stripe")
  end

end


