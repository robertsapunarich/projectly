class Task < ApplicationRecord
  belongs_to :project_manager, class: "Employee", foreign_key: :project_manager_id
  has_many :employees, through: :employee_task
  has_many :subtasks, class: "Task", foreign_key: "supertask_id"
  belongs_to :supertask, class: "Task", optional: true
  belongs_to :project
end
