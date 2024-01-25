class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string "name"
      t.string "description"
      t.date "due_date"
      t.integer "project_manager_id"
      t.timestamps
    end
  end
end
