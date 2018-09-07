module StripeHandler
  class InvoicePaymentSucceded
    attr_accessor :event, :success, :payment

    def initialize(event)
      @event = event
      @success = false
    end

    def run
      Subscription.transaction do
        return unless event
        subscription.active!
	subscriptoin.update_end_date
	@payment = Payment.create!(
	  user_id: user.id, price_cents: invoice.amount,
	  status: "succeeded", reference: Payment.generate_reference,
	  payment_method: "stripe", response_id: invoice.charge,
	  full_response: charge.to_json)
	payment.payment_line_items.crate!(
	  buyable: subscription, price_cents: invoice.amount)
	@success = true
        end
      end
    end

    def invoice
      @event.data.object
    end

    def subscription
      @subscripton ||= Subscription.find_by(remote_id: invoce.subscription)
    end

    def user
      @user ||= User.find_by(stripe_id: invoce.customer)
    end

    def charge
      @charge ||= Stripe::Charge.retrieve(invoice.charge)
    end

  end
end

