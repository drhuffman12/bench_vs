
require "benchmark"
require "json"
require "csv"

class Benchmark::BM::Tms
  include JSON::Serializable
end

class BenchNormalVsFiber
  DIGITS_CRYSTAL_WORKERS = 3

  # getter title : String
  getter batch_timestamp : Time
  getter qty_loops : Int32
  getter all_results : Array(Hash(String, Float64 | Int32 | String))
  getter env_crystal_workers : Int32

  def initialize()
    @qty_loops_env = ENV["BENCH_QTY_LOOPS"]
    @qty_loops = @qty_loops_env ? @qty_loops_env.to_i : 2000
    @batch_timestamp = Time.utc

    @all_results = Array(Hash(String, Float64 | Int32 | String)).new
    @env_crystal_workers = ENV["CRYSTAL_WORKERS"].to_i
  end

  def run(title, &block : Int32 -> Int32 | Bool)
    @all_results << bench_normal_vs_threaded(title, block)
  end

  # # NOTE: The passed in `block` is expected to take an int arg
  def run(title, &block : Int32 -> Int32 | Bool)
  
    normal = Benchmark.measure do
      qty_loops.times do |i| 
        block.call(i)
      end
    end
  
    # threads = Benchmark.measure do
    #   threads = [] of Thread
    #   qty_loops.times do |i|
    #     threads << Thread.new do     
    #       block.call(i)
    #     end
    #   end
    #   threads.map(&:join)
    # end
  
    fibers_any_thread = Benchmark.measure do
      qty_loops.times do |i|
        spawn(same_thread: false) do
          block.call(i)
        end
      end
      Fiber.yield
    end
  
    fibers_same_thread = Benchmark.measure do
      qty_loops.times do |i|
        spawn(same_thread: true) do
          block.call(i)
        end
      end
      Fiber.yield
    end
  
    results = {
      "batch_timestamp" => batch_timestamp.to_s,
      "qty_loops" => qty_loops,
      "title" => title,
      "env_crystal_workers" => env_crystal_workers,
      
      "normal" => normal.real,
      # "threads" => threads.real,
      "fibers_any_thread" => fibers_any_thread.real,
      "fibers_same_thread" => fibers_same_thread.real,
      
      # "threads" => threads.real * env_crystal_workers,
      "fibers_any_thread_times_worker" => fibers_any_thread.real * env_crystal_workers,
      "fibers_same_thread_times_worker" => fibers_same_thread.real * env_crystal_workers,
      
      # "threads" => threads.real / env_crystal_workers,
      "fibers_any_thread_per_worker" => fibers_any_thread.real / env_crystal_workers,
      "fibers_same_thread_per_worker" => fibers_same_thread.real / env_crystal_workers
    }

    @all_results << results

    results
  end
    
  def csv_formatted_header
    puts "all_results: #{all_results}"
    first = all_results.first
    header_cols = first.keys.map{|k| k.to_s}
  
    io = IO::Memory.new
    CSV.build(io) do |csv|
      csv.row header_cols
    end
    io.to_s
  end
  
  def csv_formatted_rows
    io = IO::Memory.new
    CSV.build(io) do |csv|
      all_results.each do |result|
        csv.row result.values
      end
    end
    io.to_s
  end

  def save
    csv_headers = csv_formatted_header
    csv_row_data = csv_formatted_rows
    File.write("tmp/bench.cr.ql_#{qty_loops}.row_#{"0".rjust(DIGITS_CRYSTAL_WORKERS,'0')}.csv",csv_headers)
    File.write("tmp/bench.cr.ql_#{qty_loops}.row_#{ENV["CRYSTAL_WORKERS"].rjust(DIGITS_CRYSTAL_WORKERS,'0')}.csv",csv_row_data)
  end
end
