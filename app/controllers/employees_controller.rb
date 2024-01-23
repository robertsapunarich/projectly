class EmployeesController < ApplicationController

  def create
    prepared_params = prepare_params(employee_params)
    Employee.create(prepared_params)
    render json: "success", status: :created
  end

  private

  def prepare_params(params)
    {
      name: params[:name],
      email: params[:email],
      password_digest: BCrypt::Password.create(params[:password]),
      work_focus: params[:work_focus]
    }
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :password, :work_focus)
  end
end
