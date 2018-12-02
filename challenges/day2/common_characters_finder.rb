require "../../challenges/common/input_reader"

# https://adventofcode.com/2018/day/2
class CommonCharactersFinder

  def self.find_common_characters
    input = InputReader.read_lines_from_file
    input_length = input.length-1

    (0..input_length).each do |i|
      (i..input_length).each do |j|
        common_letters = get_common_letters(input[i], input[j])
        next unless common_letters.size == input[i].size - 1

        puts "They differ by one. Position: #{i}, #{j}. Keys: #{input[i]}, #{input[j]}"
        puts "Common letters: #{common_letters.join("")}"
      end
    end
  end

  def self.get_common_letters(key1, key2)
    chars1 = key1.chars
    chars2 = key2.chars
    result = []

    (0..chars1.length).each do |i|
      next if chars2[i] != chars1[i]
      result << chars1[i]
    end

    result
  end
end

c = CommonCharactersFinder
c.find_common_characters