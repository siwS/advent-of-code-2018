require "../../challenges/common/input_reader"

class SubterraneanSustainability

  def initialize
    @state = "......#.##.###.#.##...##..#..##....#.#.#.#.##....##..#..####..###.####.##.#..#...#..######.#.....#..##...#......................................................................................................................................".chars.to_a
    @combinations = {}
    input = InputReader.read_lines_from_file
    input.each do |line|
      comb = line.split("=>").map { |x| x.strip }
      @combinations[comb[0]] = comb[1] if comb[1] == "#"
    end
  end

  def calculate_year(year)
    (0..year-1).each do |y|
      find_current_state

      puts "#{y+1} #{@state.join("")} > Sum: #{calculate_current_sum}"
    end
  end

  def find_current_state
    new_state = []
    @state.each_with_index do |_, index|
      if index < 3 || index + 2 >= @state.length
        new_state[index] = "."
        next
      end
      current_pot = @state[index-2] + @state[index-1] + @state[index] + @state[index+1] + @state[index+2]
      is_there = @combinations[current_pot]
      new_state[index] = is_there.nil? ? "." : "#"
    end
    @state = new_state
  end

  def calculate_current_sum
    sum = 0
    @state.each_with_index do |state, index|
      sum += index-6 if state == "#"
    end
    sum
  end

end

SubterraneanSustainability.new.calculate_year(130)

####
# After year 100 we see that the pattern is the same only moving towards the right 1 index at a time.
# Due to the size of the pattern (31 #) it increases 62 per iteration
# Therefore for the rest 50000000000-10=49999999900 iterations it will increase steadily by 62.
# The total count will be calculated by 6855+49999999900*62
# And yay! We achieved sustainability with a stable rate