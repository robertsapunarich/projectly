class Project < ApplicationRecord
  belongs_to :project_manager, class: "Employee", foreign_key: "project_manager_id"
  has_many :tasks
end
