class OverlapDetector

  def detect_overlaps
    input = InputReader.read_lines_from_file

    board = initialize_array
    input.each do |i|


    end

  end


  def initialize_array
    board = []
    (0...1000).each do |row|
      (0...1000).each do |cell|
        board[row][cell]=0
      end
    end
    board
  end

  def parse_line

  end
end

c = OverlapDetector.new
c.detect_overlaps