require 'byebug'
class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    # debugger
    raise "Not a PolyTreeNode" unless PolyTreeNode === node || node.nil?
    return if node == parent
    parent.children.delete(self) unless parent.nil?
    @parent = node
    node.children.push(self) unless node.nil?

  end

  def remove_child(node)
    raise "Not a child" unless children.include?(node)
    node.parent = nil
  end

  def add_child(node)
    return if node.nil?
    node.parent = self
  end

  def inspect
    @value
  end

  def dfs(target)
    # debugger
    return self if target == value
    children.each do |child|
      result = child.dfs(target)
      return result unless result ==  nil
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      current_node.children.each { |child| queue.push(child) }
    end
    nil
  end
end
