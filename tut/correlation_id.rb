class MyEventHandler
  def call(event)
    event_store.with_metadate(
      correlation_id: event.metadata[:correlation_id]
    ||
      event.event_id,
      causation_id: event.event_id
    ) do
	    # do something which triggers another events
	    event_store.publish(MyEvent.new(data: {foo: 'bar'}))
    end
  end

  private

  def event_store
    Rails.configuration.event_store
  end
end

class MyEventHandler
  def call(event)
    # do something which triggers another event
    event_store.publish_event(MyEvent.new(
      data: {foo: 'bar'},
      metadata: {
        correlation_id: event.metadata[:correlation_id]
	||
		event.event_id,
	causation_id: event.event_id
      }
    ))
  end

end




class BuildCorrelationCausationStreams
  def call(event)
    if causation_id = event.metadata[:causation_id]
	    event_store.link_event(
	      event.event_id,
	      stream_name: "causation-#{causation_id}"
	    )
    end
    if correlation_id = event.metadata[:correlation_id]
      event_store.link_event(
        event.event_id,
	stream_name: "correlation-#{correlation_id}"
      )
    end
  end
end



