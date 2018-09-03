IO.popen("ping -c 10 localhost", "r") do |pipe|
  while line = pipe.gets
    line.match(/time=(\d\.\d+) ms/)
    puts line if $1.to_f < 0.1
  end

end


