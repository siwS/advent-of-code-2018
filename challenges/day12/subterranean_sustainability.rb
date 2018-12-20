require "../../challenges/common/input_reader"

class SubterraneanSustainability

  def initialize
    @state = "......#.##.###.#.##...##..#..##....#.#.#.#.##....##..#..####..###.####.##.#..#...#..######.#.....#..##...#.......................".chars.to_a
    @combinations = {}
    input = InputReader.read_lines_from_file
    input.each do |line|
      comb = line.split("=>").map { |x| x.strip }
      @combinations[comb[0]] = comb[1] if comb[1] == "#"
    end
  end

  def calculate_year(year)
    (0..year-1).each do
      find_current_state
      puts @state.join('')
    end

    sum = 0
    @state.each_with_index do |state, index|
      sum += index-6 if state == "#"
    end
    puts sum
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


end

SubterraneanSustainability.new.calculate_year(20)