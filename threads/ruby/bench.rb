
require "benchmark"

def bench_normal_vs_threaded(qty, &block)
  Benchmark.bm do |x|
    x.report("normal") do
      qty.times do |i| 
        block.call(i)
      end
    end

    x.report("threads") do
      threads = []
      qty.times do |i|
        threads << Thread.new do     
          block.call(i)
        end
      end
      threads.map(&:join)
    end
  end
end

bench_normal_vs_threaded(10000) { |i| (0..i).to_a }
