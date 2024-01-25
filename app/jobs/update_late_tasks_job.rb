class UpdateLateTasksJob < ApplicationJob
  queue_as :default

  def perform(*args)
    late_tasks = Task.where("due_date < ?", Date.today)
    late_tasks.update_all(status: :late)
  end
end
