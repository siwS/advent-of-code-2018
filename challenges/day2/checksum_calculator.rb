require "../../challenges/common/input_reader"

class ChecksumCalculator

  def initialize
    @twos = 0
    @threes = 0
  end

  def calculate_checksum
    input = InputReader.read_lines_from_file

    input.each do |i|
      find_combinations(i.chars)
    end

    puts "Twos: #{@twos}, threes: #{@threes}. Result: #{@twos * @threes}"
  end

  private def find_combinations(chars)
    letters = {}

    chars.each do |char|
      if letters[char] == nil
        letters[char] = 1
      else
        letters[char] += 1
      end
    end

    @twos += 1 if letters.select { |_, value| value == 2 }.size > 0
    @threes += 1 if letters.select { |_, value| value == 3 }.size > 0
  end

end

c = ChecksumCalculator.new
c.calculate_checksum