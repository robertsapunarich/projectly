require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'login finds a user by email, authenticates with a password, and returns a valid jwt' do
    emp = employees(:project_manager)
    params = {
      email: emp.email,
      password: 'passpass'
    }

    post '/login', params: params

    assert_response 201
  end

  test 'login returns a 404 if an invalid password is provided' do
    emp = employees(:project_manager)
    params = {
      email: emp.email,
      password: 'badpass'
    }

    post '/login', params: params

    assert_response 404
  end

  test 'login returns a 404 if user is not found by email' do
    emp = employees(:project_manager)
    params = {
      email: 'badmail@example.com',
      password: 'passpass'
    }

    post '/login', params: params

    assert_response 404
  end

end
