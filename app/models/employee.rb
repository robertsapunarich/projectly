class Employee < ApplicationRecord
  has_many :tasks, through: :employee_task
  enum :work_focus, [:project_manager, :development, :design, :business, :research]
end
