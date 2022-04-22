![image](https://user-images.githubusercontent.com/15303963/84329647-a19cc180-ab5b-11ea-9469-09606895bbbf.png)

<div align="center"><strong>Start your next Rails 6 API project in seconds</strong></div>

![Github Actions badge](https://github.com/loopstudio/rails-api-boilerplate/workflows/Tests%20and%20Linters/badge.svg)
[![Codebeat badge](https://codebeat.co/badges/eaad967a-50bd-41b9-be06-e59a516cb732)](https://codebeat.co/a/loopstudio/projects/github-com-loopstudio-rails-api-boilerplate-master)

<sub> Created and maintained with ❤️ by <a href="[https://loopstudio.dev/](https://loopstudio.dev/)">LoopStudio</a> </sub>

<div align="center">A foundation with a focus on performance and best practices</div>

## Table of Contents

- [Main Characteristics](#main-characteristics)
- [Gems](#gems)
- [Getting Started](#getting-started)
- [Code quality](#code-quality)
- [Contributing](#contributing)
- [License](#license)

## Main Characteristics

- Language: Ruby 2.7.2+
- Framework: Rails 6.0.3+
- Webserver: Puma
- Test Framework: RSpec
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
To build quick superadmin back-office features.

#### Pagy
For those endpoints that need pagination, you should add on the controller method, for example:
```ruby
pagy, records = pagy(User.all)
pagy_headers_merge(pagy)
render json: records
```
The frontend needs to pass the query param `page` to retrieve a specific page.

#### Nilify Blanks
The [nilify_blanks](https://github.com/rubiety/nilify_blanks) line on `ApplicationRecord` adds a before validation callback to substitute all blank string fields to be `nil` instead, to ensure no blank fields are saved on the db.

## Getting Started

1.  Make sure that you have Rails 6, PostgreSQL, Redis, git cli, and bundle installed.
2.  Clone this repo using `git clone --depth=1 https://github.com/LoopStudio/rails-api-boilerplate.git <YOUR_PROJECT_NAME>`
3.  Update the values of the `.env.template` file to match your app
4.  Create your `.env` file. You have an example at `.env.template`. You should be able to copy it and set your values.
    _It's a good practice to keep the `.env.template` updated every time you need a new environment variable._
5.  Run `bundle install`
6.  Run `bundle exec rake db:create`
7.  Run `bundle exec rake db:migrate`
8.  Run `bundle exec rake db:seed`
9.  Check the test are passing running `rspec`
    _At this point you can run `rails s`  and start making your REST API calls at `http://localhost:3000`_
10.  Edit or delete the `CODEOWNERS` file in `.github` directory
11. Edit this README file to match your project title and description
 _It's a good practice to keep this file updated as you make important changes to the installation instructions or project characteristics._
12. Delete the `.github/workflows/deploy.yml` file, and uncomment the other workflows or configure your continuous deployment workflow since you might use different environments.
13. Modify the `.github/CODEOWNERS` file

## Tests

You can run the unit tests with `rspec` or `rspec` followed by a specific test file or directory.

## Code Quality

With `rake linters` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`

  When you update RuboCop version, sometimes you need to change `.rubocop.yml`. If you use [mry](https://github.com/pocke/mry), you can update `.rubocop.yml` to the latest version automatically.

- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`

Pass the `-a` option to auto-fix (only for some linterns).

## Job Monitor

Once the app is up and running, the route `/jobmonitor` will take you to the Sidekiq dashboard so you can see the status of the jobs.
This requires authentication only in production environments.

**Default Job Monitor Credentials:**
* Username: admin
* Password: admin

You change them to safer credentials by changing the env vars `JOB_MONITOR_USERNAME` and `JOB_MONITOR_PASSWORD`.

## Backoffice

Once the app is up and running, the route `/admin` will take you to the back-office built using ActiveAdmin.
The first Admin User is created when seeding if there isn't one created already.

**First Admin User Credentials:**
* Email: admin@example.com
* Password: password

For other environments other than development make sure you modify it to have safer credentials through the Rails console.

Once you log in as an Admin User you can manage other Admin Users from there.

You can change the Backoffice favico (tab icon) on `public/assets/` and match the filename on `config/initializers/active_admin.rb`.

## Continuous Deployment

**This boilerplate contains commented out code for a quick Continuous Deployment setup using Github actions and deploying to the Heroku platform.**

*(If you are not using those two tools you might simply want to remove the workflows directory and disregard the rest of these instructions.)*

Since we are used to using git-flow for branching and having **three different environments (dev, staging, and production)**, this boilerplate includes three commented out files on the `.github/workflows` folder so that, when using this repo for an actual project, you can keep these environments updated simply by doing a proper use of the branches.

* **Deploy to dev**: Triggered every time `develop` branch gets pushed to. For instance, whenever a new feature branch gets merged into the develop branch.

* **Deploy to staging**: Triggered every time somebody creates (or updates) a Pull Request to master. We usually call these branches using the format: `release/vx.y.z` but it will work regardless of the branch name. We create a release Pull Request at the end of each sprint to deploy to staging the new set of changes, and we leave the Pull Request `On Hold` until we are ready to ship to production.

* **Deploy to production**: Once the staging changes are approved by the Product Owner, we merge the release branch Pull Request into master, triggering a push on the master branch which deploys to production.

For this to work you will need the configure some Secrets on your GitHub repository. To add these go to your Github project, click on `Settings`, and then `Secrets`.

You need to add the following Secrets:

* **HEROKU_EMAIL**: Email of the owner account of the Heroku apps.
* **HEROKU_API_KEY**: API Key of the owner account of the Heroku apps. Get it by going to your Heroku account, `Account Settings`, and scroll down to reveal the `API KEY`.
* **HEROKU_DEV_APP**: Name of the development app. Eg. `my-project-develop-api`
* **HEROKU_PROD_APP**: Name of the production app. Eg. `my-project-api`
* **HEROKU_STAGING_APP**: Name of the staging app. Eg. `my-project-staging-api`

### Notes on Continuous Deployment

* You can disregard and remove the `deploy.yml` file since we use it to deploy the boilerplate code itself as we work on it, but it will probably be useless to you once you clone this repo for your real-world use case.

* If you use a different branching strategy or different environments layout, simply delete the files under the workflows directory and set up your own.

### Password reset flow

* Request for a password reset at `/users/password` with the following body:
```json
{
  "email": "<EMAIL_TO_CHANGE>"
}
```
Where `<EMAIL_TO_CHANGE>` should be a registered email or you will get the corresponding message on the response.

* An email is sent to that address with a 6 digit code.
* With a `GET` request to `users/password/edit?reset_password_token=<TOKEN>` you can verify the token validity.
* And to change the password you should send a `PUT` request to `users/password` with the following body:
```json
{
  "reset_password_token": "<TOKEN>",
  "password": "<NEW_PASSWORD>"
}
```

## Contributing

If you've noticed a bug or find something that needs to be refactored, feel free to open an issue or even better, a Pull Request!

## License

This project is licensed under the MIT license.

Copyright (c) 2020 LoopStudio.

For more information see [`LICENSE`](LICENSE)

--------

[<img src='https://loopstudio.dev/wp-content/uploads/2019/05/logoblack.png' width='300'/>](https://loopstudio.dev)
