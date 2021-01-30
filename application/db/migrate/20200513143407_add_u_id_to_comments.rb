class AddUIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :uID, :integer
  end
end
