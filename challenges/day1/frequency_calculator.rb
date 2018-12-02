require "../../challenges/common/input_reader"

# https://adventofcode.com/2018/day/1
class FrequencyCalculator

  def initialize
    @frequencies = {}
    @sum = 0
  end

  def first_frequency_found_twice
    input = InputReader.read_lines_from_file_as_int
    while true
      input.each do |i|
        @sum += i
        count = save_frequency_to_map(@sum)
        next unless count == 2

        puts "First frequency to be found twice: #{@sum}"
        return
      end
    end
  end

  def calculate_frequency_change
    input = InputReader.read_lines_from_file_as_int
      input.each do |i|
        @sum += i
      end
    puts "Final frequency: #{@sum}"
  end

  private def save_frequency_to_map(current_frequency)
    if @frequencies[current_frequency] != nil
      @frequencies[current_frequency] +=1
    else
      @frequencies[current_frequency] = 1
    end
  end

end

c = FrequencyCalculator.new
c.calculate_frequency_change

c = FrequencyCalculator.new
c.first_frequency_found_twice