class CommonCharactersFinder

  def read_input
    input = []
    File.open("input", "r") do |f|
      f.each_line do |line|
        input << line
      end
    end
    input
  end

  def find_common_characters
    input = read_input

    for i in 0..input.length-1 do
      for j in i..input.length-1 do
        if get_common_letters(input[i], input[j]).size == (input[i].size - 1)
          puts "They differ by one. Position: #{i}, #{j}. Keys: #{input[i]}, #{input[j]}"
          puts "Common letters: #{get_common_letters(input[i], input[j]).join("")}"
        end
      end
    end

  end

  def get_common_letters(key1, key2)
    chars1 = key1.chars
    chars2 = key2.chars
    result = []

    for i in 0..chars1.length-1 do
      next if chars2[i] != chars1[i]
      result << chars1[i]
    end

    result
  end
end

c = CommonCharactersFinder.new
c.find_common_characters