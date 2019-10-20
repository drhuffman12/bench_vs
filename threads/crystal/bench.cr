require "./bench_normal_vs_fiber"

def fib(n)
  return n if [0,1].includes?(n)
  fib(n-1) + fib(n-2)
end

def array_360(i)
  (0..i).map { |j| (0..j).to_a.reverse }.reverse
end

bencher = BenchNormalVsFiber.new

puts "\n# array_360:\n"
title = "array_360"
bencher.run(title) { |i| array_360(i); true }

puts "\n# fib:\n"
title = "fib"
bencher.run(title) { |n| fib(n); true }

bencher.save
