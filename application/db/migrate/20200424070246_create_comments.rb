class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content
      t.string :username
      t.integer :pID

      t.timestamps
    end
  end
end
