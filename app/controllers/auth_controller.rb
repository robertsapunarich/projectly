class AuthController < ApplicationController
  skip_before_action :authorize, only: [:login]
  
  def login
    employee = Employee.find_by_email!(login_params[:email])
    if employee.authenticate(login_params[:password])
      payload = {employee_id: employee.id, work_focus: employee.work_focus}
      token = JWT.encode(payload, Rails.application.config.jwt_secret_key)

      render json: {
        token: token
      }, status: 201
    else
      not_found
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def not_found
    render json: {
      message: "not found"
    }, status: 404
  end
end
