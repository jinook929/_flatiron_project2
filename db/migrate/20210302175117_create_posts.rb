class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :youtube
      t.text :content
      t.integer :country_id
      t.integer :user_id

      t.timestamps
    end
  end
end
