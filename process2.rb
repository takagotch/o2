f = 0.0
started_time = Time.now.to_i

3.times do
  fork do
    1000000000.times { f += 0.001 }
    printf("%.3f\n", f)
  end
end

Process.waitall
puts "It takes #{Time.now.to_i - started_time} s"






#


f = 0.0
started_time = Time.now.to_i

3.times do
  100000000.times { f += 0.001 }
  printf("%.3f\n", f)
  f = 0
end

puts "it takes #{Time.now.to_i - started_time} s"


