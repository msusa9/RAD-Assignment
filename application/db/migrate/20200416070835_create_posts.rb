class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :topic
      t.string :username
      t.string :content
      t.integer :view
      t.datetime :date
      t.integer :commentCount
      t.string :title

      t.timestamps
    end
  end
end
