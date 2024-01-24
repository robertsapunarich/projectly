class Tasks::UpdateTaskStatus < ActiveInteraction::Base
  object :employee
  object :task
  string :task_status

  def execute
    case task_status
    when "late"
      errors.add(:task_update, "you cannot mark a task as late")
    when "done"
      if employee.work_focus == "project_manager"
        task.update!(status: task_status)
      else
        errors.add(:task_update, "only a project manager may mark a task as done")
      end
    when "needs_review", "working", "not_started"
      task.update!(status: task_status)
    end

    task
  end
end