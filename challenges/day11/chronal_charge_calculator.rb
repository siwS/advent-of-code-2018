class ChronalChargeCalculator


  def initialize(grid_serial_number)
    @grid_serial_number = grid_serial_number
  end

  def calculate
    sizes = {}
    (1..297).each do |i|
      (1..297).each do |j|
        sum = 0
        (0..2).each do |window_x|
          (0..2).each do |window_y|
            sum += fuel_cell_power_level(i+window_x, j+window_y, @grid_serial_number)
          end
        end
        sizes[[i, j]] = sum
      end
    end

    key, value = sizes.max_by { |k,v| v }
    puts "key: #{key} value: #{value}"
  end

  def fuel_cell_power_level(i, j, grid_serial_number)
    rack_id = (i+10)
    no1 = (rack_id*j+grid_serial_number)*rack_id
    no1 = no1%1000
    no1/100.to_i-5
  end

  def test_values
    return fuel_cell_power_level(122,79, 57) == -5 && fuel_cell_power_level(217,196, 39) == 0 && fuel_cell_power_level(101,153, 71) == 4
  end
end

ChronalChargeCalculator.new(9810).calculate

