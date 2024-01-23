class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string "name"
      t.string "email"
      t.string "password_digest"
      t.integer "work_focus"
      t.timestamps
    end
  end
end
