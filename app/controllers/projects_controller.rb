class ProjectsController < ApplicationController


  def create
    if current_user.work_focus == "project_manager"
      project = current_user.projects.create(project_params)
      render json: project, status: 201
    else
      render json: {message: "not_authorized"}, status: 401
    end
  end

  def create_task
    if current_user.work_focus == "project_manager"
      project = Project.find(task_params[:project_id])
      task = project.tasks.create!(
        title: task_params[:title],
        description: task_params[:descripton],
        work_focus: task_params[:work_focus],
        due_date: task_params[:due_date],
        status: :not_started,
        project_manager_id: current_user.id
      )

      render json: task, status: :created
    else
      render json: {message: "not authorized"}, status: :unauthorized
    end
  end

  def create_subtask
    if current_user
      task = Task.find(task_params[:task_id])
      subtask = task.subtasks.create!(
        project_id: task.project.id,
        title: task_params[:title],
        description: task_params[:description],
        work_focus: task_params[:work_focus],
        due_date: task_params[:due_date],
        status: :not_started,
        project_manager_id: task.project_manager_id
      )
      
      render json: subtask, status: :created
    else
      render json: {message: "not authorized"}, status: :unauthorized
    end
  end

  def projects
    if current_user
      projects = Project.all

      render json: projects, status: :ok
    else
      render json: {message: "not authorized"}, status: :unauthorized
    end
  end

  def tasks
    if current_user
      project = Project.find(task_params[:project_id])
      
      render json: project.as_json(include: :tasks), status: :ok
    else
      render json: {message: "not authorized"}, status: :unauthorized
    end
  end

  private

  def project_params
    params.permit(:id, :name, :description, :due_date)
  end

  def task_params
    params.permit(:project_id, :task_id, :title, :description, :work_focus, :due_date, :project_manager_id)
  end

end
