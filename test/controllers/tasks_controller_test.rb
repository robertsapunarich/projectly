require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest

  test "a project manager can mark a task as done" do
    emp = employees(:project_manager)
    task = tasks(:task)

    params = {
      status: "done"
    }

    patch "/tasks/#{task.id}/status", headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params

    assert_response :success
    assert_equal("done", task.reload.status)
  end

  test "any other employee cannot mark a task as done" do
    emp = employees(:developer)
    task = tasks(:task)

    params = {
      status: "done"
    }

    patch "/tasks/#{task.id}/status", headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params

    assert_response :bad_request
    assert_equal("not_started", task.reload.status)
  end

  test "anyone can mark a task as not_started, working, or needs_review" do
    proj_mgr = employees(:project_manager)
    task = tasks(:task)

    params = {
      status: "working"
    }

    patch "/tasks/#{task.id}/status", headers: {"Authorization": "Bearer #{proj_mgr.jwt}"}, params: params

    assert_response :success
    assert_equal("working", task.reload.status)

    dev = employees(:developer)

    params = {
      status: "needs_review"
    }

    patch "/tasks/#{task.id}/status", headers: {"Authorization": "Bearer #{dev.jwt}"}, params: params

    assert_response :success
    assert_equal("needs_review", task.reload.status)
  end

  test "no one can mark a task as late" do
    proj_mgr = employees(:project_manager)
    task = tasks(:task)

    params = {
      status: "late"
    }

    patch "/tasks/#{task.id}/status", headers: {"Authorization": "Bearer #{proj_mgr.jwt}"}, params: params

    assert_response :bad_request
    assert_equal("not_started", task.reload.status)

    dev = employees(:developer)

    params = {
      status: "late"
    }

    patch "/tasks/#{task.id}/status", headers: {"Authorization": "Bearer #{dev.jwt}"}, params: params

    assert_response :bad_request
    assert_equal("not_started", task.reload.status)
  end

  test "a project manager may assign a task to multiple employees" do
    proj_mgr = employees(:project_manager)
    dev = employees(:developer)
    designer = employees(:designer)
    task = tasks(:task)

    params = {
      employee_ids: [
        dev.id,
        designer.id
      ]
    }

    assert_difference 'EmployeeTask.count', 2 do
      post "/tasks/#{task.id}/assign", headers: {"Authorization": "Bearer #{proj_mgr.jwt}"}, params: params
      assert_response 201
    end
    
    assert dev.tasks.count == 1
    assert designer.tasks.count == 1
  end
end
