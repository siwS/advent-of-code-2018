require "../../challenges/common/input_reader"

class ChronalCoordinates

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
        min_distance = 100000000
        coordinates.each_with_index do |coordinate|
          distance = calculate_distance(i, j, coordinate)
          if min_distance == distance
            area[i][j] = -2
          end
          if min_distance > distance
            min_distance = distance
            area[i][j] = coordinate
          end
        end
      end
    end

    (0..max_dimension-1).each do |i|
      (0..max_dimension-1).each do |j|
        coord = area[i][j]
        next unless coordinates.include? coord
        next unless is_border?(i, j, max_dimension-1) && coord != -2
        coordinates.delete(coord)
      end
    end

    coord_sizes = {}
    (0..max_dimension-1).each do |i|
      (0..max_dimension-1).each do |j|
        coord = area[i][j]
        next unless coordinates.include? coord

        if coord_sizes[coord].nil?
          coord_sizes[coord] = 1
        else
          coord_sizes[coord] +=1
        end
      end
    end

    max = 0
    coord_sizes.each do |_, size|
      if max < size
        max = size
      end
    end
    puts max
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
        board[row][cell] = -1
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

c = ChronalCoordinates.new
c.find_largest_finite_area