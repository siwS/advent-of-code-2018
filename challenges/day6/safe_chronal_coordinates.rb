require "../../challenges/common/input_reader"

class SafeChronalCoordinates

  def find_largest_finite_area
    input = InputReader.read_lines_from_file
    coordinates = []
    max_dimension = 0
    input.each do |line|
      coordinate = extract_coordinates(line)
      coordinates << coordinate
      max_dimension = coordinate.x if coordinate.x > max_dimension
      max_dimension = coordinate.y if coordinate.y > max_dimension
    end
    max_dimension += 1
    area = initialize_array(max_dimension)

    (0..max_dimension-1).each do |i|
      (0..max_dimension-1).each do |j|
        coordinates.each_with_index do |coordinate|
          distance = calculate_distance(i, j, coordinate)
          area[i][j] += distance
        end
      end
    end

    count = max_dimension*max_dimension
    (0..max_dimension-1).each do |i|
      (0..max_dimension-1).each do |j|
        if area[i][j] >= 10000
          count -= 1
        end
      end
    end

    puts count
  end

  def is_border?(i, j, size)
    i == 0 || i == size || j == 0 || j == size
  end

  def calculate_distance(i, j, coordinate)
    x_d = (coordinate.x-i).abs
    y_d = (coordinate.y-j).abs
    x_d + y_d
  end

  def extract_coordinates(line)
    split_line = line.split(",")
    Coordinates.new(split_line[1].to_i, split_line[0].to_i)
  end

  private def initialize_array(size)
    board = Array.new(size) { Array.new(size) }
    (0...size).each do |row|
      (0...size).each do |cell|
        board[row][cell] = 0
      end
    end
    board
  end

  class Coordinates
    attr_accessor :x, :y

    def initialize(x,y)
      @x = x
      @y = y
    end
  end


end

c = SafeChronalCoordinates.new
c.find_largest_finite_area