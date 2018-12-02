class InputReader

  def self.read_lines_from_file
    input = []
    File.open("input", "r") do |f|
      f.each_line do |line|
        line.strip!
        input << line
      end
    end
    input
  end

  def self.read_lines_from_file_as_int
    input = []
    File.open("input", "r") do |f|
      f.each_line do |line|
        frequency_change = line.to_i
        input << frequency_change
      end
    end
    input
  end

end