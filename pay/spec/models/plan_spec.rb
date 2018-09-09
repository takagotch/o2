require "rails_helper"

RSpec.describe Plan, type: :model do
  let(:plan) { build_stubbed(:plan) }

  context "end date" do
    
    it "end date" do
      plan.interval = "day"
      date = Date.parse("July 2, 2018")
      expect(plan.end_date_from(date)).to eq(Date.parse("July 3, 2018"))
    end

  end
end

