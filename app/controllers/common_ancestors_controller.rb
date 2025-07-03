class CommonAncestorsController < ApplicationController
  def index
    node1 = Node.find(params[:node_a_id])
    node2 = Node.find(params[:node_b_id])

    common_ancestors = node1.common_ancestors(node2)

    root = common_ancestors.min { |a, b| a.ancestor_id <=> b.ancestor_id }
    lca = common_ancestors.max { |a, b| a.ancestor_id <=> b.ancestor_id }
    depth = common_ancestors.size

    render json: {
      root: root.ancestor_id,
      lowest_common_ancestor: lca.ancestor_id,
      depth: common_ancestors.size
    }

  end
end
