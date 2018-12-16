class Node
  attr_accessor :metadata_count, :children_count, :metadata, :children

  def initialize(metadata_count, children_count)
    @metadata_count = metadata_count.to_i
    @children_count = children_count.to_i
    @children = []
    @metadata = []
  end

  def add_child(child)
    @children << child
  end

  def add_metadata(metadata)
    @metadata << metadata.to_i
  end

  def metadata_sum
    @metadata.reduce(:+)
  end

  def no_children?
    children_count == 0
  end

end