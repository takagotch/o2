#Gemfile
# ruby_event_store
source 'https://rubygems.org'

gem 'activerecord'
gem 'ruby_event_store'
gem 'rails_event_store_active_record'

gem 'sqlite3'
gem 'pg'
gem 'mysql2'

#
require 'active_record'
require 'rails_event_store_active_record'
require 'ruby_event_store'

ActvieRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

class OrderPlaced < RubyEventStore::Event
end

event_store = RubyEventStore::Client.new(
  repository:
RailsEventStoreActiveRecord::EventRepository.new
)

event_store.publish_event(OrderPlaced.new(data: {
  order_id: 1,
  customer_id: 47271,
  amount: BigDecimal.new("20.00"),
}),
  stream_name: "Order-1",
)

#gem
gem 'google-protobuf'
gem 'rails_event_store'

Rails.application.configure do
  config.to_prepare do
    Rails.configuration.event_store =
RailsEventStore::Client.new(
      repository:
RailsEventStoreActiveRecord::EventRepository.new(
        mapper: RubyEventStore::Mappers::Protobuf.new
      )
    )
  end
end


syntax = "proto3";
package my_app;

message OrderPlaced {
  string event_id = 1;
  string order_id = 2;
  string customer_id = 3;
}


#ruby
require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
	add_message "my_app.OrderPlaced" do
    optional :event_id, :string, 1
    optional :order_id, :string, 2
    optional :customer_id, :int32, 3
  end
end

module MyApp
  OrderPlaced = Google::Protobuf::DescriptorPool.
	  generated_pool.
	  lookup("my_app.OrderPlaced").
	  msgclass
end


event_store = Rails.configuration.event_store

event = MyApp::OrderPlaced.new(
  event_id: "f90b8848-e487e-9b4a-9f2a1d53622b",
  customer_id: 123,
  order_id: "K3THNX9"
)
event_store.publish_event(event, stream_name: "Order-K3THNX9")



require 'msgpack'

class MyHashToMessagePackMapper
  def event_to serialized_record(domain_event)
    SerializedRecord.new(
      event_id: domain_event.fetch('event_id'),
      metadata: "",
      data:     domain_event.to_msg_pack,
      event_type: domain_event.fetch('event_type')
    )
  end

  def serialized_record_to_event(record)
    MessagePack.unpack(record.data)
  end

  def add_metadata(event, key, value)
    event[key.to_s] = value
  end
end


Rails.application.configure do
  config.to_prepare do
    Rails.configuration.event_store = 
  RailsEventStore::Client.new(
    repository:
  RailsEventStoreActiveRecord::EventRepository.new(
      mapper: MyHashToMessagePackMapper.new
    )
    )
  end
end


Rails.configuration.event_store.publish_event({
  'event_id' => SecureRandom.uuid,
  'order_id' => 'K3THNX9',
  'event_type' => 'OrderPlaced',
  'order_amount' => BigDecimal.new('120.55')
, stream_name: 'Order$K3THNX9'})


