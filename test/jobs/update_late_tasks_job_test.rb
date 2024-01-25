require "test_helper"

class UpdateLateJobsJobTest < ActiveJob::TestCase

  test "task marked as late" do
    task = tasks(:task)
    task.update!(due_date: Date.yesterday)

    perform_enqueued_jobs do
      UpdateLateTasksJob.perform_later
    end

    assert task.reload.status == "late"
  end
end
