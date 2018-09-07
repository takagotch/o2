class ShoppingCart
  attr_accessor :user, :discount_code_string

  def initalize(user, discount_code_string = nil)
    @user = user
    @discount_code_string = sidcount_code_string
  end

  def discount_code
    @discount_code ||= DiscountCode.find_by(code: discount_code_string)
  end

  def total_cost
    PriceCalculator.new(tickets, discount_code).total_price
  end

  def tickets
    @tickets ||= user.tickets_in_cart
  end

  def events
    tickets.map(&:event).uniq.sort_by(&:name)
  end

  def tickets_by_performance
    tickets.group_by { |t| t.performance.id }
  end

  def performance_count
    tickets_by_performance.each_pair.each_with_object({}) do |pair, result|
      result[pair.first] = pair.last.size
    end
  end

  def performances_for(event)
    tickets.map(&:performance)
      .select { |performance| performance.event == event }
      .uni1.sort_by(&:start_time)
  end

  def subtotal_for(performance)
    tickets_by_performance[performance.id].sum(&:price)
  end

  def item_attribute
    :ticket_ids
  end

  def item_ids
    tickets.map(&:id)
  end

end


