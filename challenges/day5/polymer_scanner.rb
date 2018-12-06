require "../../challenges/common/input_reader"

class PolymerScanner

  attr_accessor :polymer_chars

  def scan
    @polymer_chars = InputReader.read_lines_from_file[0].chars
    while find_reacting_units
      puts @polymer_chars.size
    end

  end

  def find_reacting_units
    found = false
    index = 0

    while @polymer_chars.length-1 > index
      if @polymer_chars[index+1].downcase == @polymer_chars[index].downcase && @polymer_chars[index] != @polymer_chars[index+1]
        @polymer_chars.delete_at(index+1)
        @polymer_chars.delete_at(index)
        found = true
      end
      index += 1
    end
    found
  end


  def are_reacting?(unit_a, unit_b)
    unit_a.downcase == unit_b.downcase && unit_a != unit_b
  end
end

c = PolymerScanner.new
c.scan