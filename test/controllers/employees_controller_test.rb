require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "a project manager can create employees" do
    emp = employees(:project_manager)
    params = { 
      employee: {
        name: "Joe",
        email: "joe@example.com",
        password: "temp",
        work_focus: :development
      }
    }

    assert_difference 'Employee.count' do
      post employees_path, headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 201
    end
  end

  test "other employees cannot create employees" do
    emp = employees(:developer)
    params = { 
      employee: {
        name: "Joe",
        email: "joe@example.com",
        password: "temp",
        work_focus: :development
      }
    }

    assert_no_difference 'Employee.count' do
      post employees_path,  headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 401
    end
  end

end
