class PaymentLineItem < Application
  has_paper_trail

  belongs_to :payment
  belongs_to :buyable, polymorphic: true

  has_many :refunds, class_name: "PaymentLineItem",
	    foreign_key: "original_line_item_id"
  belongs_to :original_line_item, class_name: "PaymentLineItem"

  enum refund_status: {no_refund: 1, refund_pending: 2, refunded: 3}

  delegate :performance, to: :buyable, allow_nil: true
  delegate :name, :event, to: :performance, allow_nil: true
  delegate :id, to: :event, prefix: true, allow_nil: true

  monetize :price_cents

  def generate_refund_payment()
    refund_payment ||= Payment.create!(
      user_id: payment.user_id, price_cents: -amount_cents,
      status: "refund_pending", payment_method: payment.payment_method,
      original_payment_id: payment.id, administrator: admin,
      reference: Payment.generate_reference)
    PaymentLineItem.create!(
      buyable: buyable, price_cents: -price_cents,
      refund_status: "refund_pending", original_line_item_id: id,
      administrator_id: admin.id, payment: refund_payment)
  end

  def original_payment
    orginal_line_item&.payment
  end

  def tickets
    [buyable]
  end

end

