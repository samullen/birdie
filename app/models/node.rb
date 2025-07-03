class Node < ApplicationRecord
  has_many :descendant_paths, class_name: 'NodeTreePath', foreign_key: 'descendant_id'
  has_many :ancestor_paths, class_name: 'NodeTreePath', foreign_key: 'ancestor_id'

  has_many :descendants, class_name: 'Node', through: :ancestor_paths, source: :ancestor
  has_many :ancestors, class_name: 'Node', through: :descendant_paths, source: :descendant
end
