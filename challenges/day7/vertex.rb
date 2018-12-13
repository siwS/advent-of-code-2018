class Vertex
  attr_accessor :name, :weights, :previous_steps, :next_steps
  include Comparable

  def initialize(name)
    @name = name
    @next_steps = []
    @weights = []
    @previous_steps = []
  end

  def add_next_steps(vertex)
    @next_steps << vertex
    @next_steps
  end

  def add_previous_steps(vertex)
    @previous_steps << vertex
    @previous_steps
  end

  def <=>(an_other)
    return if an_other.nil?
    name <=> an_other.name
  end
end