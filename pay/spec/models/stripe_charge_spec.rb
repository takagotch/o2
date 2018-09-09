require "rails_helper"

describe StripeCharge, :vcr do
  let(:payment){ build_stubbed(
    :payment, price: Money.new(3000),
      reference: Payment.generate_reference) }

  describe "success", :aggregate_failures do
	  let(:token) { StripeToken.new(
	    credit_card_number: "43434343434343", expiration_month: "12",
	    expiration_year: Time.zone.year + 1, cvc: "123")}

    it "calls stripe to get a charge" do
      charge = StripeCharge.new(token: token, payment: payment)
      charge.charge
      expect(charge.response.id).to start_with("ch")
      expect(charge.response.amount).to eq(3000)
      expect(charge).to be_a_success
    end
  end

  describe "failure" do
    let(:token){ StripeToken.new(
      credit_card_number: "400000000000003", expiration_month: "12",
      expiration_year: Time.zone.now.year + 1, cvc: "123") }

    it "handles failure" do
      charge = StripeCharge.new(token: token, payment:payment)
      charge.charge
      expect(charge.response).to be_nil
      expect(charge).not_to be_a_success
    end
  end

end


