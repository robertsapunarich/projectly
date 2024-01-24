require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest

  test "a project manager can create projects" do
    emp = employees(:project_manager)

    params = {
      name: "new project",
      description: "a new project",
      due_date: "2024-12-25"
    }

    assert_difference 'Project.count', 1 do
      post '/projects', headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 201
    end

  end

  test "a project manager can create tasks" do
    emp = employees(:project_manager)
    project = projects(:test_project)

    params = {
      title: "a task",
      description: "perform this task",
      work_focus: "development",
      due_date: "2024-12-01"
    }

    assert_difference 'project.tasks.count', 1 do
      post "/projects/#{project.id}/tasks", headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 201
    end
  end

  test "a project manager can create subtasks" do
    emp = employees(:project_manager)

    task = tasks(:task)

    params = {
      title: "a subtask",
      description: "perform this subtask",
      work_focus: "development",
      due_date: "2024-12-01"
    }

    assert_difference 'task.subtasks.count', 1 do
      post "/projects/#{task.project.id}/tasks/#{task.id}/subtasks", headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 201
    end
  end

  test "any other employee cannot create projects" do
    emp = employees(:developer)

    params = {
      name: "new project",
      description: "a new project",
      due_date: "2024-12-25"
    }

    assert_no_difference 'Project.count' do
      post '/projects', headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 401
    end
  end

  test "any other employee cannot create tasks" do
    emp = employees(:developer)
    project = projects(:test_project)

    params = {
      title: "a task",
      description: "perform this task",
      work_focus: "development",
      due_date: "2024-12-01",
      project_manager_id: emp.id
    }

    assert_no_difference 'project.tasks.count' do
      post "/projects/#{project.id}/tasks", headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 401
    end
  end

  test "any other employee can create subtasks" do
    emp = employees(:developer)
    task = tasks(:task)

    params = {
      title: "a subtask",
      description: "perform this subtask",
      work_focus: "development",
      due_date: "2024-12-01"
    }

    assert_difference 'task.subtasks.count', 1 do
      post "/projects/#{task.project.id}/tasks/#{task.id}/subtasks", headers: {"Authorization": "Bearer #{emp.jwt}"}, params: params
      assert_response 201
    end
  end

end
