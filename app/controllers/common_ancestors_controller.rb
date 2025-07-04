class CommonAncestorsController < ApplicationController
  # Most of #index could be extracted to a class, but doesn't need to since
  # there is nothing else using this logic
  def index
    # Two queries in case the same node_id is passed for both params
    node1 = Node.where(id: params[:id]).limit(1).first
    node2 = Node.where(id: params[:node_b_id]).limit(1).first

    case [node1, node2]
    in Node => node1, Node => node2
      common_ancestors = node1.common_ancestors(node2)
      root = root_ancestor(common_ancestors)
      lca = lowest_common_ancestor(common_ancestors)

      response_handler(root, lca)
    else
      response_handler(nil, nil)
    end
  end

  private

  def response_handler(root, lca)
    if root.present? && lca.present?
      render json: { root: root.id, lowest_common_ancestor: lca.id, depth: lca.depth }
    else
      render json: { root: nil, lowest_common_ancestor: nil, depth: nil }
    end
  end

  # I normally would not put a method in a controller like this, but building
  # out a new class or module seemed like overkill
  def root_ancestor(paths)
    if path = paths.min { |a, b| a.ancestor_id <=> b.ancestor_id }
      path.ancestor
    end
  end

  def lowest_common_ancestor(paths)
    if path = paths.max { |a, b| a.ancestor_id <=> b.ancestor_id }
      path.ancestor
    end
  end
end
