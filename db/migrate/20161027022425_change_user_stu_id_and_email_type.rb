class ChangeUserStuIdAndEmailType < ActiveRecord::Migration[5.0]
  def change
    t = :users
    remove_column t, :stu_id, :integer
    add_column t, :stu_id, :string
    add_index t, :stu_id, unique: true
    remove_index t, {column: :email, unique: true}
  end
end
