names = %w(tky takagotch takashi)
threads = []

names.each do |name|
  thrads << Thread.new do
    3.times do |i|
      print "#{name}:#{i}, "
    end
  end
end

threads.each { |t| t.join }

puts "\name threads. are terminated."


