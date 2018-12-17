class ChronalChargeCalculator

  def initialize(grid_serial_number)
    @grid_serial_number = grid_serial_number
  end

  def kadane(array)
    max_start, max_end = -1, -1
    max, max_so_far, current_start = 0, 0, 0

    (0..array.size-1).each do |index|
      max_so_far += array[index]
      if max_so_far < 0
        max_so_far = 0
        current_start = index + 1
      end

      next unless max < max_so_far
      max_start = current_start
      max_end = index
      max = max_so_far
    end
    [max, max_start, max_end]
  end

  def calculate
    max, leftBound, rightBound, upBound, lowBound = 0, 0, 0, 0, 0

    (0..299).each do |left|
      temp = Array.new(300, 0)
      (left..299).each do |right|
        (0..299).each do |i|
          temp[i] += fuel_cell_power_level(i+1, right+1, @grid_serial_number);
        end

        result, currentUpBound, currentLowBound = kadane(temp)
        next unless result > max && is_square?(right, left, currentLowBound, currentUpBound)

        max = result
        leftBound = left
        rightBound = right
        upBound = currentUpBound
        lowBound = currentLowBound
      end
    end

    puts max, upBound+1, leftBound+1, (lowBound-upBound+1)
  end

  def is_square?(right, left, currentLowBound, currentUpBound)
    right-left == currentLowBound-currentUpBound
  end

  def fuel_cell_power_level(i, j, grid_serial_number)
    rack_id = (i+10)
    no1 = (rack_id*j+grid_serial_number)*rack_id
    no1 = no1%1000
    no1/100.to_i-5
  end

  def test_values
    fuel_cell_power_level(122,79, 57) == -5 && fuel_cell_power_level(217,196, 39) == 0 && fuel_cell_power_level(101,153, 71) == 4
  end
end

ChronalChargeCalculator.new(9810).calculate

