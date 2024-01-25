# Projectly

## [](https://github.com/robertsapunarich/projectly#setup)Setup

### [](https://github.com/robertsapunarich/projectly#clone-the-repository)Clone the repository

`git clone git@github.com:robertsapunarich/projectly.git`

or

`git clone https://github.com/robertsapunarich/projectly.git`

### [](https://github.com/robertsapunarich/projectly#install-the-gems)Install the gems

`bundle install`

### [](https://github.com/robertsapunarich/projectly#install-redis)Install Redis

Redis is needed to run background jobs with `sidekiq`. On macos:

`brew install redis`

`brew services start redis`

### [](https://github.com/robertsapunarich/projectly#start-the-server)Start the server

`rails s`

The server can be reached on `localhost` at port `3000`.

### [](https://github.com/robertsapunarich/projectly#create-a-base-employee)Create a base employee

Open a rails console:

`rails c`

Create an `Employee` model with a `project_manager` role:

```
Employee.create!(
  name: <name here>,
  email: <email>,
  password_digest: BCrypt::Password.create(<password>),
  work_focus: :project_manager
)
```

### [](https://github.com/robertsapunarich/projectly#login-to-api-with-base-employee)Login to API with base employee

Projectly uses JWTs for authentication and authorization. Using [Postman](https://www.postman.com/) or any HTTP client of your choice, `POST` to `localhost:3000/login` with the following request body to retrieve your JWT:

```
{
  "email": <email>,
  "password": <password>
}
```

The response body should look like:

```
{
  "jwt": <token>
}
```

Include the value of `jwt` as the `Bearer` token in your `Authorization` header like so:

`Authorization: Bearer <token value>`

### [](https://github.com/robertsapunarich/projectly#running-tests)Running tests

`rails t`

### [](https://github.com/robertsapunarich/projectly#running-background-jobs)Running background jobs

Projectly includes a background job that can be run to set all tasks with a past `due_date` to a `late` status.

In a separate terminal window, run sidekiq:

`bundle exec sidekiq`

In another terminal window, open a rails console with `rails c` and run:

`UpdateLateTasksJob.perform_later`

In the sidekiq terminal you should see some output like:

```
2024-01-24T19:13:15.121Z pid=31438 tid=dge class=UpdateLateTasksJob jid=63c72c81a37588afb7d60439 INFO: Performing UpdateLateTasksJob (Job ID: 6f6b7bcf-8286-46d0-869d-09acbe04b101) from Sidekiq(default) enqueued at 2024-01-24T19:13:14.599403000Z
2024-01-24T19:13:15.264Z pid=31438 tid=dge class=UpdateLateTasksJob jid=63c72c81a37588afb7d60439 INFO: Performed UpdateLateTasksJob (Job ID: 6f6b7bcf-8286-46d0-869d-09acbe04b101) from Sidekiq(default) in 142.55ms
```