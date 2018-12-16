class MarbleGame

  def initialize(number_of_players, last_marble)
    @number_of_players = number_of_players
    @last_marble = last_marble
    @marbles_array = []

    @score = {}
    (0..@number_of_players-1).each { |i| @score[i] = 0 }
  end

  def play
    puts "New game..."
    current_marble = 0
    current_marble_index = 0
    current_player = 0

    while current_marble < @last_marble
      # Initializing @marbles_array
      if @marbles_array.size <= 1
        current_marble_index = current_marble
        @marbles_array << current_marble
        current_marble += 1
        current_player = increment_player(current_player) if @marbles_array.size == 1
        next
      end

      if winning_marble?(current_marble)
        current_marble_index = calculate_new_index(current_marble_index)
        @score[current_player] += (current_marble + @marbles_array[current_marble_index])
        @marbles_array.delete_at(current_marble_index)
      elsif end_of_circle?(current_marble_index)
        current_marble_index = 1
        @marbles_array.insert(current_marble_index, current_marble)
      else
        current_marble_index += 2
        @marbles_array.insert(current_marble_index, current_marble)
      end
      current_player = increment_player(current_player)
      current_marble += 1
    end
    print_score
  end

  def calculate_new_index(current_marble_index)
    if current_marble_index - 7 > 0
      return current_marble_index - 7
    end
    @marbles_array.size + current_marble_index - 7
  end

  def end_of_circle?(current_marble_index)
    current_marble_index + 2 > @marbles_array.size
  end

  def winning_marble?(current_marble)
    current_marble % 23 == 0
  end

  def print_score
    #puts @marbles_array.join("-")
    max = 0
    @score.each do |key, value|
      #puts "Elf: #{key} scored: #{value}"
      max = value if value > max
    end
    puts "Winning score= #{max}"
  end

  def increment_player(current_player)
    if current_player < @number_of_players - 1
      current_player += 1
    else
      current_player = 0
    end
    current_player
  end

end

MarbleGame.new(9,25).play
MarbleGame.new(10,1618).play
MarbleGame.new(13,7999).play
MarbleGame.new(17,1104).play
MarbleGame.new(21,6111).play
MarbleGame.new(30,5807).play
MarbleGame.new(428,72061).play
MarbleGame.new(428,7206100).play