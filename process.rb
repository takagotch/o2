pid = Process.spawn "sleep 5; echo terminated"
puts "waiting..."
puts "waiting..."
puts "waiting..."
Process.waitpid(pid)
