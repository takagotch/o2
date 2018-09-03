require 'thread'

q = SizedQueue.new(1)
Thread.new do
  10.times do |n|
    sleep(rand)
    q.push(n)
    p [:push, n]
  end
end
Thread.new do
  10.times do |n|
    sleep(rand)
    p [:pop, q.pop]
  end
end.join

