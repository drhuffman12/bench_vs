# https://github.com/crystal-lang/crystal/blob/master/samples/mandelbrot.cr

require "colorize"
require "./selenite"

class MandelbrotB
  MAX_ITER = 32 # 10
  property x_step_count : Int32
  property y_step_count : Int32
  property xmin : Float64
  property xmax : Float64
  property ymin : Float64
  property ymax : Float64
  property xstep_size : Float64
  property ystep_size : Float64
  getter cells : Array(Array(Colorize::ColorRGB))

  COLOR_BLACK = Colorize::ColorRGB.new(0_u8,0_u8,0_u8)

  def self.run(
    x_step_count = 600,
    y_step_count = 125,
    xmin = -2.0,
    xmax = 0.5,
    ymin = -1.0,
    ymax = 1.0
  )
    m = MandelbrotB.new(x_step_count, y_step_count, xmin, xmax, ymin, ymax)
    m.mandelhelp # (xmin, xmax, xstep_size, ymin, ymax, ystep_size)
  end

  def initialize(
      @x_step_count = 600,
      @y_step_count = 125,
      @xmin = -2.0,
      @xmax = 0.5,
      @ymin = -1.0,
      @ymax = 1.0
    )

    @xstep_size = (xmax - xmin) / x_step_count
    @ystep_size = (ymax - ymin) / y_step_count

    @cells = init_cells
  end

  def init_cells
    x_step_count.times.to_a.map{|x| y_step_count.times.to_a.map{|y| COLOR_BLACK}}
  end

  def force_0u8_to_255u8(value)
    case
    when value < 0.0
      0
    when value > 255.0
      255
    else
      value.round.to_i
    end.to_u8
  end

  def color(val)
    hue = 255 * val / MAX_ITER
    # hue = (255.0 * Math.frexp(val)[1] / MAX_ITER)    
    saturation = 100.0
    value = val < MAX_ITER ? 100.0 : 0.0
    r,g,b = Selenite.hsv_to_rgb(hue, saturation, value).to_a.map{|v| force_0u8_to_255u8(v)}
    c = Colorize::ColorRGB.new(r, g, b)
  rescue e
    # debug_info = {params: {val: val}, error: {class: e.class, message: e.message, backtrace: e.backtrace} }
    # puts debug_info.pretty_inspect
    COLOR_BLACK
  end

  def print_density(d)
    print color_char(d)
  end

  def color_char(val)
    ' '.colorize.back(color(val))
  end
  
  def mandelconverger(real, imag, iters, creal, cimag)
    if iters > 255 || real*real + imag*imag >= 4
      iters
    else
      mandelconverger real*real - imag*imag + creal, 2*real*imag + cimag, iters + 1, creal, cimag
    end
  end
  
  def mandelconverge(real, imag)
    mandelconverger real, imag, 0, real, imag
  end
  
  # def mandelhelp(xmin, xmax, xstep_size, ymin, ymax, ystep_size)
  def mandelhelp # (xmin, xmax, xstep_size, ymin, ymax, ystep_size)
    ymin.step(to: ymax, by: ystep_size) do |y|
      xmin.step(to: xmax, by: xstep_size) do |x|
        print_density mandelconverge(x, y)
        
      end
      puts
    end
  end
end

# MandelbrotB.new.run_regular
MandelbrotB.run(
  x_step_count = 600,
  y_step_count = 125,
  xmin = -2.0,
  xmax = 0.5
)
