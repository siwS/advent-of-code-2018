require "../../challenges/common/input_reader"

class OverlapDetectorWithClaims

  FABRIC_SIZE = 1000

  def initialize
    @fabric_array = initialize_array
    @claims = {}
  end

  def detect_no_overlapped_claim
    input = InputReader.read_lines_from_file
    initialize_claims_hash(input.size)

    input.each do |line|
      process_line(line)
    end

    claims_no_overlap = @claims.select { |_, y| y.zero? }
    puts "Claim with no overlap: #{claims_no_overlap.keys[0]}"
  end

  private def initialize_claims_hash(input_size)
    (1..input_size).each do |claim|
      @claims[claim] = 0
    end
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

  # We need to mark as overlapped both the previous claim
  # and the current one. This is why we always store the last one on the
  # fabric square
  private def mark_for_claim(claim, i, j)
    if @fabric_array[i][j] != 0
      @claims[@fabric_array[i][j]] += 1
      @claims[claim] += 1
    end
    @fabric_array[i][j] = claim
  end

end

c = OverlapDetectorWithClaims.new
c.detect_no_overlapped_claim