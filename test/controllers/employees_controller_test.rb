require "test_helper"
require "bcrypt"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

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
      post employees_path, params: params
      assert_response 201
    end
  end

  test "other employees cannot create employees" do
    assert false
  end

end
