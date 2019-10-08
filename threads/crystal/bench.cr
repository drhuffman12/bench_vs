
require "benchmark"


# # NOTE: The passed in `block` is expected to take an int arg
  def bench_normal_vs_threaded(qty, &block : Int32 -> Int32 | Array(Array(Int32)))
  Benchmark.bm do |x|
    puts "normal ..."
    x.report("normal") do
      qty.times do |i| 
        block.call(i)
      end
    end

    # puts "threads ..."
    # x.report("threads") do
    #   threads = [] of Thread
    #   qty.times do |i|
    #     threads << Thread.new do     
    #       block.call(i)
    #     end
    #   end
    #   threads.map(&:join)
    # end

    puts "fibers (any thread) ..."
    x.report("fibers (any thread)") do
      qty.times do |i|
        spawn(same_thread: false) do
          block.call(i)
        end
      end
      Fiber.yield
    end

    puts "fibers (same thread) ..."
    x.report("fibers (same thread)") do
      qty.times do |i|
        spawn(same_thread: true) do
          block.call(i)
        end
      end
      Fiber.yield
    end

    # # NOTE: Error: Process fork is unsupported with multithread mode
    # puts "processes ..."
    # x.report("processes") do
    #   process_ids = [] of LibC::PidT
    #   qty.times do |i|
    #     pid = Process.fork do    
    #       block.call(i)
    #     end
    #     process_ids << pid
    #   end
    #   process_ids.map{|pid| Process.wait(pid)}
    # end
  end

  puts "done for qty: #{qty}"
end

def fib(n)
  return n if [0,1].includes?(n)
  fib(n-1) + fib(n-2)
end

def array_360(i)
  (0..i).map { |j| (0..j).to_a.reverse }.reverse
end

qty_loops = ENV["BENCH_QTY_LOOPS"]
qty_loops = qty_loops ? qty_loops.to_i : 2000

puts "\n# array_360:\n"
bench_normal_vs_threaded(qty_loops) { |i| array_360(i) }

puts "\n# fib:\n"
bench_normal_vs_threaded(qty_loops) { |n| fib(n) }
