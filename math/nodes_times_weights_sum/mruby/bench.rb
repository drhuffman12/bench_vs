class Bench
  def run(qty)
    q = qty || 1000

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
      # w1.each_with_index {|wrow, i| wrow.each_with_index {|wcell, j| n2[j] += wcell*n1[i] }}
      w1_row_cnt = w1.size
      w1_col_cnt = w1.first.size
      (0...w1_row_cnt).each { |row| (0...w1_col_cnt).each { |col| n2[col] += (w1[row][col])*n1[row] } }
      b = Time.now
      d = b-a
      puts "#{d},#{RUBY_ENGINE},#{MRUBY_VERSION}"
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
  end
end

def i_am_running
  f_rb = __FILE__
  f_mrb = $0
  f_rb_name, f_rb_ext = f_rb.split('.')
  f_mrb_name, f_mrb_ext = f_mrb.split('.')
  return (f_rb_name == f_mrb_name && f_rb_ext == 'rb' && f_mrb_ext == 'mrb')
end
if i_am_running
  qty = (ARGV && ARGV.size > 0 ? ARGV[0] : 0).to_i
  Bench.new.run(qty)
end

=begin
else

  puts "__FILE__:"
  puts __FILE__

  puts "$0:"
  puts $0
  __FILE__:
  mruby/bench.rb
  $0:
  mruby/bench.mrb
=end
