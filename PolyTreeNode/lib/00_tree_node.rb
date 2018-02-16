class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    raise "Not a PolyTreeNode" unless PolyTreeNode === node
    return if node == parent
    @parent = node
    node.add_child(self)
  end
end
