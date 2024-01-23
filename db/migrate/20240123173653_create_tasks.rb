class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string "title"
      t.string "description"
      t.integer "work_focus"
      t.date "due_date"
      t.integer "status"
      t.integer "project_manager_id"
      t.integer "supertask_id"
      t.integer "project_id"
      t.timestamps
    end
  end
end
