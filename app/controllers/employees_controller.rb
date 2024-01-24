class EmployeesController < ApplicationController

  def create
    if current_user.work_focus == "project_manager"
      Employee.create(employee_params)
      render json: "success", status: :created
    else
      render json: {message: "not authorized"}, status: :unauthorized
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :password, :password_confirmation, :work_focus)
  end
end
