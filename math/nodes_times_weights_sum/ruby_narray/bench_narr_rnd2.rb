# TODO: add ruby/narray benchmarking
require 'narray'
class NArray
  def from_function!(level=0, indices=[], &block)
    if level < shape.size
      (0...(shape[level])).each do |s|
        new_indices = indices.dup
        new_indices << s
        self[*new_indices] = block.call(new_indices) if new_indices.size == shape.size
        from_function!(level+1, new_indices, &block)
      end
    end
    self
  end
end

debug = false
# debug = true
#debug = ARGV[0] == "-d"
a = Time.now
q = 100
# w1 = uninitialized Float64[10000]
# w1 = Array.new(q) { Array.new(q) { rand() } }
w1 = NArray.float(q,q).from_function!{rand()}
n = NArray.float(q).from_function!{rand()}
# w2 = w1.collect {|w| n[i+=1]*w }
#w2 = (0..n.length-1).map{|i| n[i]*w1.slice(true,i)}
w2 = NArray.float(q,q).from_function! {|x,y| n[y]*w1[x,y] }
if debug
  p w1
  p n
  p w2
end
b = Time.now
d = b-a
puts "duration: #{d}"
