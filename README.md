<img src="https://user-images.githubusercontent.com/31075855/70083079-85d3c400-15ea-11ea-9199-e43730a5a9e7.jpg" alt="rails boilerplate banner" align="center" />

<div align="center"><strong>Start your next Rails 6 API project in seconds</strong></div>

[![CircleCI](https://circleci.com/gh/LoopStudio/rails-api-boilerplate/tree/master.svg?style=svg&circle-token=de33ad2b6d5c55959e90ad4fd4edd4120da1070b)](https://circleci.com/gh/LoopStudio/rails-api-boilerplate/tree/master)

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

- Language: Ruby 2.X.X
- Framework: Rails 6
- Test Framework: Rspec
- Databases: Postgres & Redis
- Async Processor: Sidekiq

## Gems

#### puma
 webserver

#### dotenv-rails
For environment variables

#### Devise
We use [devise](https://github.com/plataformatec/devise) for authentication

#### Jb
For API json views

#### Pagy
For those endpoints that need pagination, you should add on the controller method, for example:
```ruby
pagy, records = pagy(User.all)
pagy_headers_merge(pagy)
render json: records
```

## Getting Started

1.  Make sure that you have Rails 6, PostgreSQL, git cli and bundle installed.
2.  Clone this repo using `git clone --depth=1 https://github.com/LoopStudio/rails-api-boilerplate.git <YOUR_PROJECT_NAME>`
3.  Create your `.env` file. You have an example at `.env.template`. You should be able to copy it and set your own values.
    _It's a good practice to keep the `.env.template` updated every time you need a new environment variable._
4.  Run `bundle install`
5.  Run `bundle exec rake db:create`
6.  Run `bundle exec rake db:migrate`
7.  Run `bundle exec rake db:seed`
8.  Check the test are passing running `rspec`
    _At this point you can run `rails s`  and start making your REST API calls at `http://localhost:3000`_
9.  Edit or delete the `CODEOWNERS` file in `.github` directory
10. Edit this README file to match your own project title and description
 _It's a good practice to keep this file updated as you make important changes to the installation instructions or project characteristics._

## Tests

You can run the unit tests with `rspec` or `rspec` followed by a specific test file or directory.


## Code Quality

With `rake analyze_code` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`
- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`

Pass the `-a` option to auto-fix (only for some linterns).

## Job Monitor

Once the app is up and running, the route `/jobmonitor` will take you to the Sidekiq dashboard so you can see the status of the jobs.

## Contributing

If you've noticed a bug or find something that needs to be refactored, feel free to open an issue or even better, a Pull Request!

## License

This project is licensed under the MIT license.

Copyright (c) 2019 Loop Studio.

For more information see [`LICENSE`](LICENSE)

---------

[<img src='https://loopstudio.dev/wp-content/uploads/2019/05/logoblack.png' width='300'/>](https://loopstudio.dev)
