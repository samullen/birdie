class CommonAncestorsController < ApplicationController
  def index
    node1 = Node.find(params[:node_a_id])
    node2 = Node.find(params[:node_b_id])

    root = root_ancestor(node1, node2).descendant
    lca = lowest_common_ancestor(node1, node2).descendant

    render json: {
      root: root.id,
      lowest_common_ancestor: lca.id,
      depth: lca.depth
    }
  end

  private

  def common_ancestors(node1, node2)
    @common_ancestors ||= node1.common_ancestors(node2)
  end

  def root_ancestor(node1, node2)
    common_ancestors(node1, node2).
      min { |a, b| a.ancestor_id <=> b.ancestor_id }
  end

  def lowest_common_ancestor(node1, node2)
    common_ancestors(node1, node2).
      max { |a, b| a.ancestor_id <=> b.ancestor_id }
  end
end
