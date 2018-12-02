class FrequencyCalculator

  def read_input
    input = []
    File.open("input", "r") do |f|
      f.each_line do |line|
        frequency_change = line.to_i
        input << frequency_change
      end
    end
    input
  end

  # https://adventofcode.com/2018/day/1
  def calculate_frequency_change
    frequencies = {}
    sum = 0
    input = read_input
    while true
      input.each do |i|
        sum += i
        count = save_frequency_to_map(sum, frequencies)
        if count == 2
          puts "First frequency to be found twice: #{sum}"
          return
        end
      end
    end
    puts sum
  end

  def save_frequency_to_map(sum, frequencies)
    if frequencies[sum] != nil
      frequencies[sum] +=1
    else
      frequencies[sum] = 1
    end
  end


end

c = FrequencyCalculator.new
c.calculate_frequency_change
