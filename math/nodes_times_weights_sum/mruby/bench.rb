q = ARGV[0].to_i || 1000
if q <= 0
  puts "command format: ruby #{__FILE__} [<qty>] [-v]"
  puts "  <qty> : array width (lenght assumed to be the same)"
  puts "  v    : show your work"
else
  debug = ARGV[1] == "v"
  a = Time.now
  n1 = Array.new(q) { rand() }
  w1 = Array.new(q) { Array.new(q) { rand() } }
  n2 = Array.new(q,0)
  w1.each_with_index {|wrow, i| wrow.each_with_index {|wcell, j| n2[j] += wcell*n1[i] }}
  b = Time.now
  d = b-a
  puts "#{d},#{RUBY_ENGINE},#{RUBY_VERSION}"
  if debug
    w2 = w1.map.with_index {|wrow, i| wrow.map.with_index {|wcell, j| wcell*n1[i] }}
    puts "\nn1:"
    p n1
    puts "\nw1:"
    p w1
    puts "\nw2:"
    p w2
    puts "\nn2:"
    p n2
  end
end