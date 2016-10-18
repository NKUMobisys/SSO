class AddStuIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stu_id, :integer
    add_index :users, :stu_id, unique: true
  end
end
