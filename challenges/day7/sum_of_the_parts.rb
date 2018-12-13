require "../../challenges/common/input_reader"
require "../../challenges/day7/graph"
require "../../challenges/day7/vertex"

class SumOfTheParts

  def initialize
    @traversed = []
    @available = []
  end

  def find_order
    input = InputReader.read_lines_from_file
    graph = Graph.new

    input.each do |line|
      first_step = find_first_step(line)
      second_step = find_second_step(line)
      first_vertex = graph.find_or_create_by(first_step)
      second_vertex = graph.find_or_create_by(second_step)
      first_vertex.add_next_steps(second_vertex)
      second_vertex.add_previous_steps(first_vertex)
    end

    @available = graph.find_root.sort!

    while @available.size > 0
      traverse(@available[0])
    end

    puts @traversed.join("")
  end

  def traverse(node)
    @traversed << node.name
    @available.delete(node)
    node.next_steps.each do |step|
      step.previous_steps.delete(node)
      if step.previous_steps.size == 0
        @available << step
        @available.sort!
      end
    end
  end


  def find_first_step(line)
    /(?<=Step )(\w+)/.match(line)[0]
  end

  def find_second_step(line)
    /(?<=step )(\w+)/.match(line)[0]
  end
end

c = SumOfTheParts.new
c.find_order