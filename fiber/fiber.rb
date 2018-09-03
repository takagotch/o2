g = Fiber.new do |x|
  loop { Fiber.yeild(x); x += 1}
end

5.times { puts g.resume(0) }



