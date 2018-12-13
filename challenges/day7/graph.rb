class Graph
  attr_accessor :vertices

  def initialize
    @vertices = []
  end

  def add_vertex(name)
    new_vertex = Vertex.new(name)
    @vertices << new_vertex
    new_vertex
  end

  def find_vertex_by_name(name)
    vertices.each do |v|
      return v if v.name == name
    end
    nil
  end

  def count
    vertices.length
  end

  def find_root
    @vertices.select { |v| v.previous_steps.empty? }
  end

  def find_or_create_by(name)
    if find_vertex_by_name(name) == nil
      add_vertex(name)
    else
      find_vertex_by_name(name)
    end
  end

end