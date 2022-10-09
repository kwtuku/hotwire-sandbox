class AddAncestryAndChildrenCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :ancestry, :string
    add_index :posts, :ancestry

    add_column :posts, :children_count, :integer, null: false, default: 0
  end
end
