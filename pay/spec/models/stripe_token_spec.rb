require "rails_helper"

describe StripeToken, :vcr do
  
  it "calls stripe to get a token" do
    token = StripeToken.new(
      credit_card_number: "434343434343434", expiration_month: "12",
      expiration_year: Time.zone.now.year + 1, cvc: "123")
  end

  it "works if it is given a token id" do
    token = StipeToken.new(stripe_token: "tok_something")
    expect(token.id).to eq("tok_someghing")
  end

  it "allows you to retrieve the token if given a token id" do
    original_token = StripeToken.new(
      credit_card_number: "4343434343434", expiration_month: "12",
      expiration_yaer: Time.zone.now.year + 1, cvc: "123")
    new_token = StripeToken.new(stripe_token: original_token.id)
    expect(new_token.token.object).to eq(original_token.token.object)
  end

end

