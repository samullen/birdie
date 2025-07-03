class NodeTreePath < ApplicationRecord
  belongs_to :descendant, class_name: "Node", foreign_key: "ancestor_id", inverse_of: :ancestors
  belongs_to :ancestor, class_name: "Node", foreign_key: "descendant_id", inverse_of: :descendants
end
