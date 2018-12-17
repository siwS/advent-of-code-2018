require "../../challenges/common/input_reader"
require "../day10/point"

class StarsAlign

  def initialize
    @points = []
    input = InputReader.read_lines_from_file
    input.each do |line|
      position = parse_position(line)[0]
      velocity = parse_velocity(line)[0]
      @points << Point.new(position, velocity)
    end
  end

  def show_message
    min_diff_y = 10000000
    min_t = 0

    # random sample of t-s to check
    # when y-s are getting closer (and more possible to form letters)
    (0..15000).each do |t|
      _, _, min_y, max_y = find_min_max
      d_y = max_y - min_y
      if d_y < min_diff_y
        min_diff_y = d_y
        min_t = t
      end
      move_points(t)
    end

    move_points(min_t-1)
    min_x, max_x, min_y, max_y = find_min_max
    initialize_canvas(max_x - min_x, max_y - min_y)
    put_points_in_place(max_x, max_y)
    draw_sky
  end

  def find_min_max
    max_x, max_y = 0, 0
    min_x, min_y = 10000, 10000
    @points.each do |point|
      max_x = point.x if point.x > max_x
      min_x = point.x if point.x < min_x
      max_y = point.y if point.y > max_y
      min_y = point.y if point.y < min_y
    end
    [min_x, max_x, min_y, max_y]
  end

  def initialize_canvas(dim_x, dim_y)
    @canvas = Array.new(dim_x+1) { Array.new(dim_y+1) }
    (0..dim_x).each do |i|
      (0..dim_y).each do |j|
        @canvas[i][j] = " "
      end
    end
  end

  def put_points_in_place(max_x, max_y)
    @points.each do |point|
      @canvas[point.x-max_x-1][point.y-max_y-1] = "#"
    end
  end

  def move_points(t)
    @points.each do |point|
      point.move(t)
    end
  end

  def draw_sky
    @canvas.each do |row|
      puts row.join("")
    end
  end

  def parse_position(line)
    /(?<=position=<)([ ]|-)*(\w+),([ ]|-)*(\w+)(?>)/.match(line)
  end

  def parse_velocity(line)
    /(?<=velocity=<)([ ]|-)*(\w+),([ ]|-)*(\w+)(?>)/.match(line)
  end
end

StarsAlign.new.show_message


  ##       ###  ######  #    #  #    #  #    #  #    #  ######
 #  #       #        #  ##   #  #    #  #    #  #   #   #
#    #      #        #  ##   #   #  #   #    #  #  #    #
#    #      #       #   # #  #   #  #   #    #  # #     #
#    #      #      #    # #  #    ##    ######  ##      #####
######      #     #     #  # #    ##    #    #  ##      #
#    #      #    #      #  # #   #  #   #    #  # #     #
#    #  #   #   #       #   ##   #  #   #    #  #  #    #
#    #  #   #   #       #   ##  #    #  #    #  #   #   #
#    #   ###    ######  #    #  #    #  #    #  #    #  ######