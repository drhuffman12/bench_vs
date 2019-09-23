
require "benchmark"


# # NOTE: The passed in `block` is expected to take an int arg
  def bench_normal_vs_threaded(qty, &block : Int32 -> Array(Int32))
  Benchmark.bm do |x|
    x.report("normal") do
      qty.times do |i| 
        block.call(i)
      end
    end

    # x.report("threads") do
    #   threads = [] of Thread
    #   qty.times do |i|
    #     threads << Thread.new do     
    #       block.call(i)
    #     end
    #   end
    #   threads.map(&:join)
    # end

    x.report("fibers (any thread)") do
      qty.times do |i|
        spawn(same_thread: false) do
          block.call(i)
        end
      end
      Fiber.yield
    end

    x.report("fibers (same thread)") do
      qty.times do |i|
        spawn(same_thread: true) do
          block.call(i)
        end
      end
      Fiber.yield
    end
  end
end

bench_normal_vs_threaded(10000) { |i| (0..i).to_a }
