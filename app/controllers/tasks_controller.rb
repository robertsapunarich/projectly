class TasksController < ApplicationController

  def update_status
    if current_user
      task_id = task_status_params[:task_id]
      task_status = task_status_params[:status]
      task = Task.find(task_id)
      outcome = Tasks::UpdateTaskStatus.run(employee: current_user, task: task, task_status: task_status)

      if outcome.errors.any?
        render json: outcome.errors.messages, status: 400
      else
        task = outcome.result
        render json: task, status: 200
      end
    else
      render json: {message: "not_authorized"}, status: 401
    end
  end

  private

  def task_status_params
    params.permit(:task_id, :status)
  end

end
