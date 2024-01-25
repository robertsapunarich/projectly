class AddIndices < ActiveRecord::Migration[7.1]
  def change
    add_index :employees, :id, unique: true
    add_index :projects, :id, unique: true
    add_index :tasks, :id, unique: true
    add_index :tasks, :supertask_id
    add_index :employee_tasks, [:employee_id, :task_id], unique: true
  end
end
