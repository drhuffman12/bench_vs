
require "benchmark"

def bench_normal_vs_threaded(qty, &block)
  Benchmark.bm do |x|
    puts "normal ..."
    x.report("normal") do
      qty.times do |i| 
        block.call(i)
      end
    end

    puts "threads ..."
    x.report("threads") do
      threads = []
      qty.times do |i|
        threads << Thread.new do     
          block.call(i)
        end
      end
      threads.map(&:join)
    end

    puts "processes ..."
    x.report("processes") do
      process_ids = []
      qty.times do |i|
        pid = Process.fork do    
          block.call(i)
        end
        process_ids << pid
      end
      process_ids.map{|pid| Process.wait(pid)}
    end
  end

  puts "done for qty: #{qty}"
end

# qty_loops = 10000
# # bench_normal_vs_threaded(qty_loops) { |i| (0..i).to_a.reverse

# bench_normal_vs_threaded(qty_loops) { |i| (0..i).map { |j| (0..j).to_a.reverse }.reverse } }


def fib(n)
  return n if [0,1].include?(n)
  fib(n-1) + fib(n-2)
end

def array_360(i)
  (0..i).map { |j| (0..j).to_a.reverse }.reverse
end

qty_loops = ENV['BENCH_QTY_LOOPS']
qty_loops = qty_loops ? qty_loops.to_i : 2000

puts "\n# array_360:\n"
bench_normal_vs_threaded(qty_loops) { |i| array_360(i) }

puts "\n# fib:\n"
bench_normal_vs_threaded(qty_loops) { |n| fib(n) }
