require "../../challenges/common/input_reader"
require "../../challenges/day7/graph"
require "../../challenges/day7/vertex"

class SumOfThePartsWithWorkers

  NUM_WORKERS = 5

  def initialize
    input = InputReader.read_lines_from_file
    @graph = Graph.new
    build_graph(input)

    @traversed = {}
    @next_task = {}
    (0..NUM_WORKERS-1).each do |i|
      @traversed[i] = []
      @next_task[i] = 0
    end

    @all_traversed = []
    @available = []
  end

  def find_order
    @available = @graph.find_root.sort!

    mins_passed = 0
    while @graph.vertices.length > @all_traversed.length
      workers = workers_available(mins_passed)

      (0..workers.size-1).each do |i|
        next if @available[0].nil?
        node_to_traverse = @available[0]
        traverse(node_to_traverse, workers[i], mins_passed)
      end

      add_available(mins_passed)
      mins_passed += 1
    end
  end

  def traverse(node, i, mins_passed)
    @traversed[i] << node
    @next_task[i] = mins_passed + calculate_time_for_char(node.name)
    @all_traversed << node
    @available.delete(node)
    puts "At #{mins_passed} traversing #{node.name} by worker #{i} for #{@next_task[i]} secs"
  end

  def add_available(mins_passed)
    @traversed.each do |i, nodes|
      last_node = nodes.last
      next if last_node.nil?

      if mins_passed >= @next_task[i] -1
        last_node.next_steps.each do |step|
          next if already_traversed?(step)

          if all_previous_steps_completed?(step, mins_passed)
            @available << step
          end
        end
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

  def workers_available(mins_passed)
    available = []
    (0..NUM_WORKERS-1).each do |i|
      available << i if @next_task[i]-1 <= mins_passed
    end
    available
  end

  def calculate_time_for_char(char)
    (1 + char.ord - ?A.ord) + 60
  end

  def build_graph(input)
    input.each do |line|
      first_step = find_first_step(line)
      second_step = find_second_step(line)
      first_vertex = @graph.find_or_create_by(first_step)
      second_vertex = @graph.find_or_create_by(second_step)
      first_vertex.add_next_steps(second_vertex)
      second_vertex.add_previous_steps(first_vertex)
    end
  end

  def all_previous_steps_completed?(step, mins_passed)
    step.previous_steps.all? { |prev_step| step_completed?(prev_step, mins_passed) }
  end

  def step_completed?(step, mins_passed)
    @traversed.each do |worker, nodes|
      if nodes.last == step
        return true if @next_task[worker]-1 <= mins_passed
      else if nodes.include?(step)
             return true
           end
       end
    end
    false
  end

  def already_traversed?(step)
    @all_traversed.include?(step)
  end
end

c = SumOfThePartsWithWorkers.new
c.find_order