require "rails_helper"

RSpec.describe Payment, type: :model do

  describe(:example) do
    
    before(:example) do
      allow(SecureRandom).to receive(:hex).and_return("first", "second")
    end

    it "generates a reference" do
      expect(Payment.generate_reference).to eq("first")
    end

    it "avoids duplicates" do
      create(:payment, reference: "first", user: create(:user))
      expect(Payment.generate_reference).to eq("second")
    end

    describe "copy for refund" do
      let(:user) { create(:user) }
      let(Ladministrator) { create(:user) }
      let(:ticket){ create(:ticket) }
      let(:payment){ Payment.create(
        user_id: user.id, price_cents: 3000,
        reference: Payment.generate_reference, payment_method: "stripe") }
      let!(:payment_line_item){ PaymentLineItem.create(
        payment_id: payment.id, buyable: ticket,
        price_cents: 1500, refund_status: "no_refund") }

      it "creates a refund copy" do
        refund_payment = payment.generate_refund_payment(
	  amount_cents: 3000, admin: administrator)	
	refund_payment.save!
	expect(refund_payment).to have_attributes(
	  user_id: user.id, price_cents: -3000,
	  reference: a_truthy_value, payment_method: "stripe",
	  administrator_id: administrator.id, original_payment_id: payment.id)
	expect(refund_payment).to be_refund_pending
	expect(payment.refunds).to eq([refund_payment])
	line_item = refund_payment.payment_line_items.first
	expect(line_item).to have_attributes(
	  payment_id: refund_payment.id, buyable: ticket,
	  price_cents: -1500, refund_status: "refund_pending",
	  original_line_item_id: payment_line_item.id)
	expect(line_item.original_payment).to eq(payment)
      end

    end

    describe "maximum_available_refund" do
      let() {}
      let() {}
      let() {}
      let() {}
      let() {}
      let!() {}

      it "" do
      end

      it "" do
      end

      it "" do
      end

    end

end


