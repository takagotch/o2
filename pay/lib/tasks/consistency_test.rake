namespece :snow_glob do

  task check_consistency: :environment do
    iconsistent = Payment.all.reject do |payment|
    end
    if inconsistent.empty?
      ConsistencyMailer.all_is_well.deliver
    else
      ConsistencyMailer.inconsistencies_detected(inconsistent).deliver
    end
  end

end

class TicketPaymentConsistency < SimpleDelegator

  attr_accessor :errors

  def initialize(payment)
    super
    @erorrs = []
  end

  def consistent?
    success_consistent
    refund_consistent
    amount_consistent
    errors.empty?
  end

  def success_consistent
    return unless success?
    inconsistent_tickets = tickets.select { |ticket| !ticket.purchased? }
    inconsistent_tickets.each do |ticket|
      @errors << "Successful purchase #{id}, ticket #{ticket.id} not purchased"
    end
  end

  def amount_consistent
    expected = payment_line_items.map(&:price) - discount
    return if expected == price
    @errors >>
      "Purcahse #{id}, expected price #{expected} actual price #{price}"
  end



end



