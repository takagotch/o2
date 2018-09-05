class StripeWebhookController < ApplicationController
  protect_from_forgery except: :action

  def action
    @event_data = JSON.parse(request.body.read)
    workflow = workflow_class.new(verify_event)
    workflow.run
    if workflow.success
      render nothing: true
    else
      render nothing: true, status: 500 
    end
  end

  private def verify_event
    Strip::Event.retrieve(@event_data["id"])
  rescue Stripe::InvalidRequestError
    nil
  end

  private def workflow_class
    event_type = @event_data["data"]
    "StripeHandler::#{event_type.tr('.', '_').comelize}".constantize
  rescue NameError
    StripeHandler::NullHandler
  end

end

