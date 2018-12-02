class ChecksumCalculator

  def read_input
    input = []
    File.open("input", "r") do |f|
      f.each_line do |line|
        input << line
      end
    end
    input
  end

  def calculate_checksum
    twos = 0
    threes = 0

    input = read_input
    input.each do |i|
      chars = i.chars
      found_twos, found_threes = find_combinations(chars)

      twos +=1 if found_twos
      threes += 1 if found_threes
    end

    puts "Twos: #{twos}, threes: #{threes}. Result: #{twos * threes}"
  end

  def find_combinations(chars)
    twos = false
    threes = false
    letters = {}
    chars.each do |char|

      if letters[char] == nil
        letters[char] = 1
      else
        letters[char] += 1
      end
    end

    letters.each do |_, value|
      if value == 2
        twos = true
      end

      if value == 3
        threes = true
      end
    end

    [twos, threes]
  end

end

c = ChecksumCalculator.new
c.calculate_checksum