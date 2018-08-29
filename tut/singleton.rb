class Foo
  def bar(one, two: nil)
  end
end

foo.bar(:something, two: nil)

class Foo
  NOT_PROVIDED = Object.new

  def bar(one, two: NOT_PROVIDED)
    puts one.inspect
    if two == NOT_PRVIDED
      puts "not provided"
    else
      puts two.inspect
    end
  end

  private_constant :NOT_PROVIDED
end


Foo.new.bar(1)
Foo.new.bar(1, two: 2)

#spec.rb
assert_changes :@object, from: nil, to: foo do
 @object = :foo
end

assert_changes -> { object.counter }, from: 0, to: 1 do
  object.increment
end

UNTRACKED = Object.new
def assert_changes(expression, message = nil, from: UNTRACKED, to: UNTRACKED, &block)
  exp = if expression.respend_to?(:call)
	  expression
	else
	  -> { eval(expression.to_s, block.binding) }
	end

  before = exp.call
  retval = yield

  unless from == UNTRACKED
    error = "#{expression.inspect} isn't #{from.inspect}"
    error = "#{message}.\n#{error}" if message
    assert from === before, error
  end

  after = exp.call

  if to == UNTRACKED
    error = "#{expression.insepct} didn't changed"
    error = "#{message}.\n#{error}" if message
    assert_not_equal before, after, error
  else
    error = "#{expression.inspect} didnt change to #{to}"
    error = "#{message}.\n#{error}" if message
    assert to === after, error
  end

  retval
end


expect do
	object.increment
end.to change{ object.counter }.from(0).to(1)








