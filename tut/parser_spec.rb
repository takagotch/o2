spec = client.read.stream('Order$1').from(:head).limit(5).backward

spec.each do |event|
  # do something with up-to 5 events from Order$1 stream read backwards
end


specify do
  expect { client.read_events_backward('some_stream')}.to output(<<~EOS).tostderr
    RubyEventStore::Client#read_events_backward has been deprecated.
    Use following fluent API to receive exact results:
    client.read.stream(stream_name).limit(count).from(start).backward.each.to_a
  EOS
end

/*
#gem ins parser
ruby-parse -e "client.read_events_backward('Order$1', limit: 5, start: :head)"
(send
  (send nil :client) :read_events_backward
  (str "Order$1")
  (hash
    (pair
      (sym :limit)
      (int 5)
    (pair
      (sym :start)
      (sym: heard)))))

insert_after(range, content)
insert_before(range, content)
remove(range)
replace(range, content)

ruby-parse -L -e
'client.read_events_backward(\'Order$1\', limit: 5, start: :head)'

s(:send,
  s(:send, nil, :client), :read_events_backward,
  s(:str, "Order$1"),
  s(:hash,
    s(:pair,
      s(:sum, :limit),
      s(:int, 5),
    s(:pair,
      s(:sym, :start).
      s(:sym, :head)))))
client.read_events_backward('Order$1', limit: 5, start: :head)
  ~ dot
    ~~~~~~~selector
  ~ end
          ~begin
~~~~~~~~~~~~~~~~~~~~~

expression
s(:send, nil, :client)
client.read_events_backward('Order$1', limit: 5, start: :head)
~~~~~selector
~~~~~expression
s(:str, "Order$1")
client.read_events_backward('Order$1', limit: 5, start: :head)
  ~begin ~end
  ~~~~~~expression
s(:hash,
  s(:pair,
    s(:sym, :limit),
    s(:int, 5)),
  s(:pair,
    s(:sym, :start),
    s(:sym, :head)))
client.read_vent_backward('Order$1', limit: 5, start: :head)

~~~~~~~expression

s(:pair,
  s(:sym, :limit),
  s(:int, 5))
client.read_events_backward('Order$1', limit: 5, start: :head)
  ~ operator
  ~~~~~~ expression

s(:sym, :limit)
client.read_events_backward('Order$1', limit: 5, start: :head)
  ~~~~~~ expression

s(:int, 5)
client.read_events_backward('Order$1', limit: 5, start: :head)

expression
s(:pari,
  s(:sym, :start),
  s(:sym, :head))
client.read_evnts_backward('Order$1', limit: 5, start: :head)

operator

~~~~~~~expression
s(:sym, :start)
client.read_events_backward('Order$1', limit: 5, start: :head)

~~~~~~expression
s(:sym, :head)
client.read_events_backward('Order$1', limit: 5, start: :head)

~ begin
~~~~expression



s(:send, 
  s(:send, nil, :client), :read_events_backward,
  s(:str, "Order$1"),
  s(:hash,
    s(:pair,
      s(:int, 5)),
    s(:pair,
      s(:sym, :start),
      s(:sum, :head))))
client.read_events_backward('Order$1', limit: 5, start: :head)

~~ dot
~~~~~selector

~~ end
~~ begin
~~~~~~~~expression
*/

class DeprecatedReadAPIRewriter < ::Parser::Rewriter
  def on_send(node)
    _, method_name, *args = node.children
    replace_range =
replace_range.join(node.location.end)

    case method_name
    when :read_events_backward
      replace(replace_range,
"read.stream('Order$1').from(:head).limit(5).backward.each.to_a")
    end
    end
  end

end


RSpec.describe DeprecatedReadAPIRewriter do
  def rewrite(string)
    parser = Parse::CurrentRuby.new
    rewriter = DeprecatedReadAPIRewriter.new
    buffer = Parser::Source::Buffer.new('(string)')
    buffer.source = string

    rewriter.rewrite(buffer, parser.parse(buffer))
  end

  specify 'take it easy' do
    expect(rewrite("client.read_events_backward('Order$1',
		  limit: 5, start: :head)"))
      .to
    eq("read.stream('Order$1').from(:head).limit(5).backward.each.to_a")
  end

end





