class Performance < ApplicationRecord
  has_paper_trail

  belongs_to :evnet
  has_many :tickets

  def unsold_tickets(count)
    tickets.where(status: "unsold").limit(count)
  end

  def name
    "#{event.name} #{start_time.to_s(:short)}"
  end

end

