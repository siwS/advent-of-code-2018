require "../../challenges/common/input_reader"

class MineCartMadness

  def initialize(size)
    @canvas = Array.new(size) { Array.new(size) }
    @initial_canvas = Array.new(size) { Array.new(size) }
    @autos = []

    input = InputReader.read_lines_from_file_no_strip
    input.each_with_index do |line, index|
      @initial_canvas[index] = line.chars
      @canvas[index] = line.chars
      detect_auto(@canvas[index], index)
    end

  end

  def find_crash
    print_canvas
    while true
      @autos.each do |auto|
        old_position = auto.position
        old_direction = auto.direction
        new_position = auto.move
        if is_auto?(@canvas[new_position[0]][new_position[1]])
          puts "Boom!!!! #{new_position[1]}:#{new_position[0]}"
          print_canvas
          return
        end
        remove_from_old_position(old_position, old_direction)
        auto.turn(@canvas[new_position[0]][new_position[1]])
        new_direction = auto.direction
        add_in_new_position(new_position, new_direction)
      end

    end

  end

  def print_canvas
    @canvas.each do |line|
      puts line.join("")
    end
    puts "----------------------------"
  end

  def remove_from_old_position(old_position, direction)
    unless is_auto?(@initial_canvas[old_position[0]][old_position[1]])
      @canvas[old_position[0]][old_position[1]] = @initial_canvas[old_position[0]][old_position[1]]
      return
    end

    # if we don't have the initial state fall back to direction
    @canvas[old_position[0]][old_position[1]] = "-" if direction > 2
    @canvas[old_position[0]][old_position[1]] = "|" if direction <= 2
  end

  def add_in_new_position(new_position, direction)
    @canvas[new_position[0]][new_position[1]] = "^" if direction == 1
    @canvas[new_position[0]][new_position[1]] = "v" if direction == 2
    @canvas[new_position[0]][new_position[1]] = "<" if direction == 3
    @canvas[new_position[0]][new_position[1]] = ">" if direction == 4
  end

  def detect_auto(line, x)
    line.each_with_index do |char, y|
      next unless is_auto?(char)
        @autos << Auto.new([x, y], 0, char)
    end
  end

  def is_auto?(char)
    char == "v" || char == "<" or char == ">" or char == "^"
  end

  class Auto

    attr_accessor :direction, :position
    # 1 is up
    # 2 is down
    # 3 is left
    # 4 is right
    def initialize(position, turns, char)
      @direction = 1 if char == "^"
      @direction = 2 if char == "v"
      @direction = 3 if char == "<"
      @direction = 4 if char == ">"
      @position = position
      @turns = turns
    end

    def move
      @position = [@position[0]-1, @position[1]] if @direction == 1
      @position = [@position[0]+1, @position[1]] if @direction == 2
      @position = [@position[0], @position[1]-1] if @direction == 3
      @position = [@position[0], @position[1]+1] if @direction == 4
      @position
    end

    def turn(char)
      if char == "/"
        @direction = 4 and return if @direction == 1
        @direction = 3 and return if @direction == 2
        @direction = 2 and return if @direction == 3
        @direction = 1 and return if @direction == 4
      end
      if char == "\\"
        @direction = 3 and return if @direction == 1
        @direction = 4 and return if @direction == 2
        @direction = 1 and return if @direction == 3
        @direction = 2 and return if @direction == 4
      end
      if char == "+"
        turn_left if @turns%3 == 0
        turn_right if @turns%3 == 2
        @turns += 1
      end
    end

    def turn_left
      @direction = 3 and return if @direction == 1
      @direction = 4 and return if @direction == 2
      @direction = 2 and return if @direction == 3
      @direction = 1 and return if @direction == 4
    end

    def turn_right
      @direction = 4 and return if @direction == 1
      @direction = 3 and return if @direction == 2
      @direction = 1 and return if @direction == 3
      @direction = 2 and return if @direction == 4
    end
  end
end

MineCartMadness.new(150).find_crash
