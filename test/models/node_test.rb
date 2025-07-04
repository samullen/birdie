require "test_helper"

class NodeTest < ActiveSupport::TestCase
  describe "#common_ancestors" do
    it "returns all ancestors (node_tree_paths) two nodes share" do
      root = nodes(:root)
      child = nodes(:child)
      grandchild = nodes(:grandchild)

      common_ancestors = child.common_ancestors(grandchild)

      assert common_ancestors.one? {|a| a.ancestor_id == root.id}
      assert common_ancestors.one? {|a| a.ancestor_id == child.id}
      refute common_ancestors.one? {|a| a.ancestor_id == grandchild.id}
    end

    it "returns an empty list if there are no commonalities" do
      node = nodes(:orphan)
      other_node = nodes(:root)

      assert node.common_ancestors(other_node).empty?
    end
  end

  describe "#depth" do
    it "returns the depth of the node in the tree" do
      node = nodes(:child)

      assert node.depth == 2
    end

    it "returns 0 for the root node" do
      node = nodes(:root)

      assert node.depth == 1
    end
  end
end
