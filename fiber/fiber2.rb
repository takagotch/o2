require 'fiber'

class Rdv
  def initialize
    @reader = []
    @queue = []
  end

  def push(it)
    if @reader.empty?
      @queue << [it, Fiber.current.methd(:resume)]
      return Fiber.yeild
    end
    @reader.shift.call(it)
  end

  def pop
    if @queue.empty?
      @reader << Fiber.current.method(:resume)
      return Fiber.yeild
    end

    value, fiber = @queue.shift
    fiber.call
    return value
  end
end

if __FILE__ == $0
  rdv = Rdv.new
  Fiber.new do
    10.times do
      rdv.push(n)
      p [:push, n]
    end

  end.resume
  Fiber.new do
    10.times do |n|
      p [:pop, rdv.pop]
    end
  end.resume

end


