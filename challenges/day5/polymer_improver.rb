require "../../challenges/common/input_reader"
require "../../challenges/day5/polymer_scanner"

class PolymerImprover

  def find_shorter_polymer
    input = InputReader.read_lines_from_file[0].chars

    min_polymer = 1000000

    ("a".."z").each do |letter|
      input_without_letter = input.map(&:clone)
      input_without_letter.delete(letter.upcase)
      input_without_letter.delete(letter)
      scanner = PolymerScanner.new(input: input_without_letter)
      result = scanner.scan
      min_polymer = result if result < min_polymer
    end

    puts min_polymer
  end

end

c = PolymerImprover.new
c.find_shorter_polymer