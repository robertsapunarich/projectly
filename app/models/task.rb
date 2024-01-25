class Task < ApplicationRecord
  belongs_to :project_manager, class_name: "Employee", foreign_key: :project_manager_id
  has_many :employee_tasks
  has_many :employees, through: :employee_tasks
  has_many :subtasks, class_name: "Task", foreign_key: "supertask_id"
  belongs_to :supertask, class_name: "Task", optional: true
  belongs_to :project

  enum :status, [:not_started, :working, :needs_review, :done, :late]

  def assign!(employee_id)
    EmployeeTask.create!(employee_id: employee_id, task_id: id)
  end
end
