class CreateLikesAndAddLikesCountToPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :post, null: false, foreign_key: true, index: false
      t.references :user, null: false, foreign_key: true
      t.index %i[post_id user_id], unique: true

      t.timestamps
    end

    add_column :posts, :likes_count, :integer, null: false, default: 0
  end
end
