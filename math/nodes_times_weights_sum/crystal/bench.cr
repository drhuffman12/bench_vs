class Bench

  def self.time_delta_to_secs(time_delta)
    return 0 if (time_delta.to_s == "")
    parts = time_delta.to_s.split(":")
    parts[0].to_i*60*60 + parts[1].to_i*60 + parts[2].to_f
  end

  def self.run(qty)
    q = qty || 1000

    if q <= 0
      puts "command format: ruby #{__FILE__} [<qty>] [-v]"
      puts "  <qty> : array width (lenght assumed to be the same)"
      puts "  -v    : show your work"
    else
      debug = (ARGV && ARGV.size > 1 ? ARGV[1] : "") == "v"
      a = Time.now
      n1 = Array.new(q) {|q| rand() }
      w1 = Array.new(q) {|i| Array.new(q) {|j| rand() } }
      n2 = Array.new(q) { 0.0 }
      w1.each_with_index {|wrow, i| wrow.each_with_index {|wcell, j| n2[j] += wcell*n1[i] }}
      b = Time.now
      d = time_delta_to_secs(b-a)
      puts "#{d},Crystal,#{Crystal::VERSION}"
      if debug
        w2 = w1.map_with_index {|wrow, i| wrow.map_with_index {|wcell, j| wcell*n1[i] }}
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
  end
end

if PROGRAM_NAME == $0
# if __FILE__ == $0
  qty = (ARGV && ARGV.size > 0 ? ARGV[0] : 0).to_i
  Bench.run(qty)
end

# puts "__FILE__:"
# puts __FILE__

# puts "$0:"
# puts $0

# puts "PROGRAM_NAME:"
# puts PROGRAM_NAME
