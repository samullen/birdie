class CreateNodeTreePaths < ActiveRecord::Migration[8.0]
  def change
    create_table :node_tree_paths do |t|
      t.column :ancestor_id, :integer, null: false
      t.column :descendant_id, :integer, null: false
    end

    add_index :node_tree_paths, [:ancestor_id, :descendant_id], unique: true
    add_index :node_tree_paths, :ancestor_id
    add_index :node_tree_paths, :descendant_id
  end
end
