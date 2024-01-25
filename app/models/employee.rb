class Employee < ApplicationRecord
  has_secure_password
  has_many :employee_tasks
  has_many :tasks, through: :employee_tasks
  has_many :projects, foreign_key: "project_manager_id"
  enum :work_focus, [:project_manager, :development, :design, :business, :research]

  def jwt
    payload = {employee_id: self.id, work_focus: self.work_focus}
    JWT.encode(payload, Rails.application.config.jwt_secret_key)
  end
end
