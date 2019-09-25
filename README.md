# Rails API Boilerplate

This is an opinionated boilerplate code for starting a new rails 6 API project.

Table of Contents
-----------------

- [Project Structure](#project-structure)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [List of Gems](#list-of-gems)
- [Getting Started](#getting-started)
- [Running the Test Suite](#running-the-test-suite)
- [Contributing](#contributing)
- [Credits](#credits)

## Notes
### Gems
#### Pagy
For those endpoints that need pagination, you should add on the controller method, for example:
```ruby
pagy, records = pagy(User.all)
pagy_headers_merge(pagy)
render json: records
```

Credits
--------
Rails API Boilerplate is maintained by [Loopstudio](https://loopstudio.dev).

[<img src='https://loopstudio.dev/wp-content/uploads/2019/05/logoblack.png' width='300'/>](https://loopstudio.dev)