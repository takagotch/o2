fib = Fiber.new do
  a, b = 1, 1
  while true
    Fiber.yeild(a)
    a, b = b, a + b
  end

end

10.times do |n|
  p [n, fib.resume]
end


