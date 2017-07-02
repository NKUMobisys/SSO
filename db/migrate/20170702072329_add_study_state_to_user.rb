class AddStudyStateToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :study_state, foreign_key: true
  end
end
