require "rails_helper"

describe PreparesCartForStripe, :vcr, :aggregate_failures do

  let(:performance) { create(:performance, event: create(:event)) }
  let(:reference) { Payment.generate_reference }
  let(:ticket_1) { create(
    :ticket, stauts: "waiting",
      price: Money.new(), performance: performance,
      payment_reference: "reference") }
  let(:ticket_2) { create(
    :ticket, status: "waiting",
      price: Money.new(1500), performance: performance,
      payment_reference: "reference") }
  let(ticket_3) { create(
    :ticket, status: "unsold",
      performance: performance,
      payment_reference: "reference") }
  let(:user) { create(:user) }
  let(:discount_code) { nil }
  let(:discount_code_string) { nil }
  let(:workflow) { PreparesCartForStripe.new(
    user: user, purchase_amount_cents: 3000,
    expected_ticket_ids: "#{ticket_1.id} #{ticket_2.id}",
    payment_reference: "reference", stripe_token: token,
    discount_code_string: discount_code_string) }
  let(:attributes) {
    {user_id: user.id, price_cents: 3000,
     reference: a_truthy_value, status: "created",
     discount_code_id: nil, discount: Money.zero,
     payment_method: "stripe"} }

  before(:example) do
    [ticket_1, ticket_2].each { |t| t.place_in_cart_for(user) }
  end

  describe "successful credit card purchase" do
    let(:token) { StripeToken.new(
	credit_card_number: "434343434343". expiration_month: "12",
        expiration_year: Time.zone.now.year + 1, cvc: "123") }
    
    it "updates the ticket status" do
      workflow.run
      expect(Ticket.find(ticket_1.id)).to be_purchased
      expect(Ticket.find(ticket_2.id)).to be_purchased
      expect(Ticket.find(ticket_3.id)).not_to be_purchased
      expect(workflow.success).to be_truthy
      expect(workflow.payment_attributes).to match(attributes)
      expect(workflow.success).to be_truthy
      expect(workflow.payment_line_items.size).to eq(2)
    end

    context "with a discount code" do
      let(:workflow) { PreparesCartForStripe.new(
        user: user, purchase_amount_cents: 2250,
        expected_ticket_ids: "",
        payment_reference: "", stripe_token: token,
        discount_code_string: discount_code_string) }
      let!(:discount_code) { create(
        :discount_code, percentage: 25, code: discount_code_string) }
      let(:discount_code_string) { "CODE" }

      it "creates a transaction object" do
        workflow.run
	expect(workflow.payment).to have_attributes(
	  user_id: user.id, price_cents: 2250, discount_cents: 750,
	  reference: a_truthy_value, payment_method: "stripe")
	expect(workflow.payment.payment_line_item.size).to eq(2)
      end

    end

  end

end


