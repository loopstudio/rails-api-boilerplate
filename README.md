<img src="https://user-images.githubusercontent.com/31075855/70083079-85d3c400-15ea-11ea-9199-e43730a5a9e7.jpg" alt="rails boilerplate banner" align="center" />

<div align="center"><strong>Start your next Rails 6 API project in seconds</strong></div>

[![CircleCI](https://circleci.com/gh/loopstudio/rails-api-boilerplate.svg?style=svg&circle-token=de33ad2b6d5c55959e90ad4fd4edd4120da1070b)](https://circleci.com/gh/loopstudio/rails-api-boilerplate)
[![codebeat badge](https://codebeat.co/badges/eaad967a-50bd-41b9-be06-e59a516cb732)](https://codebeat.co/a/loopstudio/projects/github-com-loopstudio-rails-api-boilerplate-master)

<sub> Created and maintained with ❤️ by <a href="[https://loopstudio.dev/](https://loopstudio.dev/)">Loop Studio</a> </sub>

<div align="center">A foundation with focus on performance and best practices</div>

## Table of Contents

- [Main Characteristics](#main-characteristics)
- [Gems](#gems)
- [Getting Started](#getting-started)
- [Code quality](#code-quality)
- [Contributing](#contributing)
- [License](#license)

## Main Characteristics

- Language: Ruby 2.6.0
- Framework: Rails 6.0.2.1
- Webserver: Puma
- Test Framework: Rspec
- Databases: Postgres & Redis
- Async Processor: Sidekiq

## Other Gems

#### dotenv-rails
For environment variables

#### Devise
We use [devise](https://github.com/plataformatec/devise) for authentication

#### Jb
For building API json views

#### ActiveAdmin
To build quick superadmin backoffice features.

#### Pagy
For those endpoints that need pagination, you should add on the controller method, for example:
```ruby
pagy, records = pagy(User.all)
pagy_headers_merge(pagy)
render json: records
```

#### Nilify Blanks
The [nilify_blanks](https://github.com/rubiety/nilify_blanks) line on `ApplicationRecord` adds a before validation callback in order to substitute all blank string fields to be `nil` instead, in order to ensure no blank fields are saved on the db.

## Getting Started

1.  Make sure that you have Rails 6, PostgreSQL, git cli and bundle installed.
2.  Clone this repo using `git clone --depth=1 https://github.com/LoopStudio/rails-api-boilerplate.git <YOUR_PROJECT_NAME>`
3.  Update the values of the `.env.template` file to match your app
4.  Create your `.env` file. You have an example at `.env.template`. You should be able to copy it and set your own values.
    _It's a good practice to keep the `.env.template` updated every time you need a new environment variable._
5.  Run `bundle install`
6.  Run `bundle exec rake db:create`
7.  Run `bundle exec rake db:migrate`
8.  Run `bundle exec rake db:seed`
9.  Check the test are passing running `rspec`
    _At this point you can run `rails s`  and start making your REST API calls at `http://localhost:3000`_
10.  Edit or delete the `CODEOWNERS` file in `.github` directory
11. Edit this README file to match your own project title and description
 _It's a good practice to keep this file updated as you make important changes to the installation instructions or project characteristics._
12. Delete the `.github/workflows/deploy.yml` file, and configure your own Continuous deployment, since you probably use multiple environments.
13. Modify the `.github/CODEOWNERS` file

## Tests

You can run the unit tests with `rspec` or `rspec` followed by a specific test file or directory.


## Code Quality

With `rake linters` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`

  When you update RuboCop version, sometimes you need to change `.rubocop.yml`. If you use [mry](https://github.com/pocke/mry), you can update `.rubocop.yml` to latest version automatically.

- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`

Pass the `-a` option to auto-fix (only for some linterns).

## Job Monitor

Once the app is up and running, the route `/jobmonitor` will take you to the Sidekiq dashboard so you can see the status of the jobs.
This requires authentication only on production environments.

Default Job Monitor Credentials:
* Username: admin
* Password: admin

You change them to safer credentials by changing the env vars `JOB_MONITOR_USERNAME` and `JOB_MONITOR_PASSWORD`.

## Backoffice

Once the app is up and running, the route `/admin` will take you to the backoffice built using ActiveAdmin.
The first Admin User is created when seeding if there isn't one created already.

First Admin User Credentials:
* Email: admin@example.com
* Password: password

For other environments other than development make sure you modify it to have safer credentials through the Rails console.

Once you log in as an Admin User you can manage other Admin Users from there.

You can change the Backoffice favico (tab icon) on `public/assets/` and match the filename on `config/initializers/active_admin.rb`.

## Contributing

If you've noticed a bug or find something that needs to be refactored, feel free to open an issue or even better, a Pull Request!

## License

This project is licensed under the MIT license.

Copyright (c) 2019 Loop Studio.

For more information see [`LICENSE`](LICENSE)

---------

[<img src='https://loopstudio.dev/wp-content/uploads/2019/05/logoblack.png' width='300'/>](https://loopstudio.dev)
