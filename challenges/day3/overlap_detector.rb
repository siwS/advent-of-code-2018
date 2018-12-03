require "../../challenges/common/input_reader"

class OverlapDetector

  FABRIC_SIZE = 1000

  def initialize
    @board = initialize_array
    @count = 0
  end

  def detect_overlaps
    input = InputReader.read_lines_from_file
    input.each do |line|
      starting_point, dimensions = parse_line(line)
      starting_x, starting_y = calculate_starting_points(starting_point)
      dimension_x, dimension_y = calculate_dimensions(dimensions)
      mark_on_board(starting_x, dimension_x, starting_y, dimension_y)
    end
    puts @count
  end

  private def initialize_array
    board = Array.new(FABRIC_SIZE) { Array.new(FABRIC_SIZE) }
    (0...FABRIC_SIZE).each do |row|
      (0...FABRIC_SIZE).each do |cell|
        board[row][cell] = 0
      end
    end
    board
  end

  private def parse_line(line)
    line = line.split("@")[1]
    starting_point = line.split(":")[0]
    dimensions = line.split(":")[1]
    [starting_point, dimensions]
  end

  private def calculate_starting_points(starting_point)
    starting_x = starting_point.split(",")[0]
    starting_y = starting_point.split(",")[1]
    [starting_x.to_i, starting_y.to_i]
  end

  private def calculate_dimensions(dimensions)
    dimension_x = dimensions.split("x")[0]
    dimension_y = dimensions.split("x")[1]
    [dimension_x.to_i, dimension_y.to_i]
  end

  private def mark_on_board(starting_x, dimension_x, starting_y, dimension_y)
    ending_x = starting_x + dimension_x - 1
    ending_y = starting_y + dimension_y - 1
    (starting_x..ending_x).each do |i|
      (starting_y..ending_y).each do |j|
        @board[i][j] += 1
        @count += 1 if @board[i][j] == 2
      end
    end
  end

end

c = OverlapDetector.new
c.detect_overlaps