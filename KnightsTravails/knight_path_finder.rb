require_relative 'poly_tree_node'
require 'byebug'
class KnightPathFinder
  attr_reader :move_tree_root, :visited_positions

  def initialize(start_pos)
    @pos = start_pos
    @move_tree_root = PolyTreeNode.new(start_pos)
    @visited_positions = Hash.new(false)
    build_move_tree(move_tree_root)
  end

  def build_move_tree(root)
    debugger
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      next_positions = new_move_positions(current_node.value)
      next_positions.each { |position| queue.push(PolyTreeNode.new(position)) }
    end
    root
  end

  def new_move_positions(position)
    @visited_positions[position] = true

    possible_moves = candidate_moves(position)
    possible_moves.select! {|move| valid_position?(move) }

    possible_moves.each { |move| visited_positions[move] = true }
  end

  def candidate_moves(position)
    move_vectors = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
    possible_moves = []

    move_vectors.each do |vector|
      move = add_two_two_tuple_vectors(position, vector)
      possible_moves.push(move)
    end
  end

  def add_two_two_tuple_vectors(left, right)
    [left[0] + right[0], left[1] + right[1]]
  end

  def valid_position?(position)
    return false if visited_positions.include?(position)
    position.all? { |coord| coord.between?(0,7) }
  end
end
