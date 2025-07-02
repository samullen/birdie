class CreateNodes < ActiveRecord::Migration[8.0]
  def change
    create_table :nodes do |t|
      t.column :parent_id, :integer, null: true
    end

    add_index :nodes, :parent_id
  end
end
