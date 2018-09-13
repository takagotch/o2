class EmployeeRegisterd < Event
  def self.schema
	  {
	    company_id: STRING_ID,
	    employee_id: STRING_ID,
	    first_name: String,
	    last_name: String,
	    department_id: STRING_ID,
	    manager_id: STRING_ID,
	    resume_id: STRING_ID
	  }
  end
end




class EmployeeRegistered < Event
  def self.schema
    {
      company_id: STRING_ID,
      employee_id: STRING_ID
    }
  end

  class EmployeeMovedToDepartment < Event
  end

  class EmployeeNameProvided < Event
  end

  class EmployeeAssignedToManager < Event
  end

  class EmployeeResumeProvided < Event
  end

end









class CancelOrderService
  def call(order_id, user_id)
  end

  private

  def publish_event(order)
    event_store.publish(
      OrderCancelled.new(data: {
        order_id: order.id,
	customer_id: order.customer_id,
      }),
      stream_name: "Order-#{order.id}"
    )
  end

  def event_store
    Rails.configuration.event_store
  end

end



