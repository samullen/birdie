class Node < ApplicationRecord
  has_many :birds, inverse_of: :node

  has_many :descendant_paths, class_name: 'NodeTreePath', foreign_key: 'ancestor_id'
  has_many :ancestor_paths, class_name: 'NodeTreePath', foreign_key: 'descendant_id'

  has_many :descendants, class_name: 'Node', through: :descendant_paths, source: :descendant
  has_many :ancestors, class_name: 'Node', through: :ancestor_paths, source: :ancestor

  def common_ancestors(other_node)
    # I let CoPilot write this
    self.ancestor_paths.where(ancestor_id: other_node.ancestor_paths.pluck(:ancestor_id))
  end

  def depth
    self.ancestor_paths.count
  end
end
