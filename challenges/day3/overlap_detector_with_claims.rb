require "../../challenges/common/input_reader"

class OverlapDetectorWithClaims

  FABRIC_SIZE = 1000

  def initialize
    @board = initialize_array
    @claims = []
  end

  def detect_no_overlapped_claim
    input = InputReader.read_lines_from_file
    @claims = (1..input.size).to_a
    input.each do |line|
      process_line(line)
    end
    puts @claims
  end

  private def process_line(line)
    claim, starting_point, dimensions = parse_line(line)
    starting_x, starting_y = calculate_starting_points(starting_point)
    dimension_x, dimension_y = calculate_dimensions(dimensions)
    mark_on_board(starting_x, dimension_x, starting_y, dimension_y, claim)
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
    claim = line.split("@")[0].delete('#').to_i
    line = line.split("@")[1]
    starting_point = line.split(":")[0]
    dimensions = line.split(":")[1]
    [claim, starting_point, dimensions]
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

  private def mark_on_board(starting_x, dimension_x, starting_y, dimension_y, claim)
    ending_x = starting_x + dimension_x - 1
    ending_y = starting_y + dimension_y - 1
    (starting_x..ending_x).each do |i|
      (starting_y..ending_y).each do |j|
        mark_for_claim(claim, i, j)
      end
    end
  end

  private def mark_for_claim(claim, i, j)
    if @board[i][j] != 0
      @claims.delete(@board[i][j])
      @claims.delete(claim)
    end
    @board[i][j] = claim
  end

end

c = OverlapDetectorWithClaims.new
c.detect_no_overlapped_claim