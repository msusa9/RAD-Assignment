class AddDateToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :date, :datetime
  end
end
