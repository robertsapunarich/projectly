class ApplicationController < ActionController::Base

  def current_user
    @user ||= begin
      header = request.headers['Authorization']
      
      Rails.logger.debug("header: #{header}")
      if header
        token = header.split(" ")[1]
        decoded = JWT.decode(token, Rails.application.config.jwt_secret_key, true, algorithm: 'HS256')
        employee_id = decoded[0]["employee_id"]
        employee = Employee.find(employee_id)
        
        employee
      else
        nil
      end
    end
  end
  
end
