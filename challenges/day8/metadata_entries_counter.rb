require "../../challenges/common/input_reader"
require "../../challenges/day8/node"

class MetadataEntriesCounter

  def calculate
    input = InputReader.read_lines_from_file
    license = input[0].split(" ")
    node = parse_node(license)
    puts calculate_value(node)
    puts calculate_metadata(node)
  end

  def parse_node(license)
    node = Node.new(license[1], license[0])
    license.delete_at(0)
    license.delete_at(0)
    node.children_count.to_i.times do
      node.add_child(parse_node(license))
    end
    node.metadata_count.to_i.times do
      node.add_metadata(license[0])
      license.delete_at(0)
    end
    node
  end

  def calculate_metadata(node)
    sum = 0
    node.children.each do |child|
      sum += calculate_metadata(child)
    end
    sum += node.metadata_sum
    sum
  end

  def calculate_value(node)
    return node.metadata_sum if node.no_children?
    value = 0
    node.metadata.each do |metadata|
      next if node.children[metadata-1].nil?
      value += calculate_value(node.children[metadata-1])
    end
    value
  end

end

MetadataEntriesCounter.new.calculate