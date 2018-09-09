require "rails_helper"

RSpec.describe CreatesPlan, :vcr, :aggregate_failures do

  it "creates a plan" do
    workflow = CreatesPlan.new(
      remote_id: "basic_monthly_#{Time.now.to_i}", name: "Basic Monthly",
      price_cents: 2000, interval: "month",
      tickets_allowed: 1, ticket_category: "mezzanine")
    workflow.run
    expect(workflow.plan).to have_attributes(
      remote_id: a_string_starting_with("basic_monthly"),
      name: "Basic Monthly", price_cents: 2000,
      interval: "month", tickets_allowed: 1,
      ticket_category: "mezzanine")
    expect(workflow.plan.remote_plan).to have_attributes(
      id: a_string_starting_with("basic_monthly"), amount: 2000,
      interval_count: 1, trial_period_days: nil)
  end

end


