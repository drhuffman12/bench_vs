debug = false
# debug = true
a = Time.now
q = 100 
w1 = Array.new(q) { Array.new(q) { rand() } }
n = Array.new(q) { rand() }
# w2 = w1.map_with_index {|wx, i| wx.map {|wy| n[i]*wy} }
w2 = w1.map {|wx| wx.map_with_index {|wy, j| n[j]*wy} }
if debug
  p w1
  p n
  p w2
end
b = Time.now
d = b-a
puts "duration: #{d}"

# $ ./bench_arr_rnd2 
# duration: 00:00:00.0007474
# duration: 00:00:00.0008844
# duration: 00:00:00.0008046
# duration: 00:00:00.0007585
# duration: 00:00:00.0008625


#require "option_parser"
#OptionParser.parse! do |parser|
#  parser.banner = "Usage: crystal bench_arr_rnd2.rb [arguments]"
#  parser.on("-d", "--debug", "Debug mode") { debug = true }
#  parser.on("-h", "--help", "Show this help") { puts parser }
#end

# w1 = uninitialized Float64[10000]