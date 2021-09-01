# ProblemDetails

[![CI](https://github.com/nikushi/problem_details/actions/workflows/ci.yml/badge.svg)](https://github.com/nikushi/problem_details/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/problem_details.svg)](https://badge.fury.io/rb/problem_details)

ProblemDetails is an implementation of [RFC7807 Problem Details for HTTP APIs](https://tools.ietf.org/html/rfc7807).

The RFC defines a "problem detail" as a way to inform errors to clients as machine readable form in a HTTP response
to avoid the need to define new error response formats for HTTP APIs.

This library also works with Rails and Sinatra, by the `problem` renderer that helps to respond with the problem detail form.

Currently only JSON serialization is supported.

## Features

* Provides the class that implements a Problem Details JSON Object.
* With Rails, automatically adds the renderer to respond with `Content-Type: application/problem+json` which works with `render` in controllers.

## Supported Versions

* Ruby 2.4.x, 2.5.x, 2.6.x
* Rails 4.x, 5.x
* Sinatra >= 1.4

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'problem_details'
```

Or if you use with Rails, add below line instead.

```ruby
gem 'problem_details-rails'
```

With Sinatra, add below line instead.

```ruby
gem 'sinatra-problem_details'
```

And then execute:

    $ bundle

## Usage

### Build a problem

```ruby
require 'problem_details'

ProblemDetails::Document.new(status: 404).to_json

# Or status code symbol can be specified as well.
ProblemDetails::Document.new(status: :not_found).to_json
```

will produce:

```json
{
  "title": "Not Found",
  "status": 404
}
```

As above, the value of `type` is implied to be `about:blank` by default if the value is ommited, also the value of `title` is filled automatically from the status code. These are described in [Predefined Problem Types](https://tools.ietf.org/html/rfc7807#section-4.2):

> The "about:blank" URI, when used as a problem type, indicates that the problem has no additional semantics beyond that of the HTTP status code.

> When "about:blank" is used, the title SHOULD be the same as the recommended HTTP status phrase for that code (e.g., "Not Found" for 404, and so on)

> ..."about:blank" URI is the default value for that ["type"] member.  Consequently, any problem details object not carrying an explicit "type" member implicitly uses this URI.

But you may also have the need to add some little hint, e.g. as a custom detail of the problem:

```ruby
ProblemDetails::Document.new(status: 503, detail: 'Database not reachable').to_json
```

will produce:

```json
{
  "title": "Service Unavailable",
  "status": 503,
  "detail": "Database not reachable"
}
```

You can build a problem with any additional members which are described as [extension members](https://tools.ietf.org/html/rfc7807#section-3.2).

```ruby
ProblemDetails::Document.new(
  status: :forbidden,
  type: 'https://example.com/probs/out-of-credit',
  balance: 30,
  accounts: ['/account/12345', '/account/67890'],
).to_json
```

will produce(note that `balance` and `accounts` are extention members):

```json
{
  "type": "https://example.com/probs/out-of-credit",
  "title": "Forbidden",
  "status": 403,
  "balance": 30,
  "accounts": [
    "/account/12345",
    "/account/67890"
  ]
}
```

### With Rails

Once `problem_details-rails` gem is installed into a Rails system, a problem can be rendered with the problem detail form with `Content-Type: application/problem+json`.

For example, respond with validation error messages:

```ruby
# app/controllers/api/posts_controller.rb
class Api::PostsController < ApplicationController
  def create
    @post = Post.new(params[:post])
    if @post.save
      render json: @post
    else
      render problem: { errors: @post.errors }, status: :unprocessable_entity
    end
  end
end
```

With `render problem: { ... }`, generated HTTP response will be like:

```
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/problem+json; charset=utf-8

{
  "title": "Unprocessable Entity",
  "status": 422,
  "errors": {
    "body": [
      "can't be blank"
    ]
  }
}
```

### With Sinatra

Install `sinatra-problems_details` into a sinatra app, a problem is be rendered as well with `Content-Type: application/problem+json`.

#### Classic Application

```ruby
require 'sinatra'
require 'sinatra-problem_details'

get '/' do
  status 400
  problem foo: 'bar'
end
```

#### Modular Application

```ruby
require 'sinatra/base'
require 'sinatra-problem_details'

class MyApp < Sinatra::Base
  register Sinatra::ProblemDetails

  get '/' do
    status 400
    problem foo: 'bar'
  end
end
```

#### Response

The sinatra apps defined in the previous sections will render:

```
HTTP/1.1 400 Bad Request
Content-Type: application/problem+json

{
  "title": "Bad Request",
  "status": 400,
  "foo": "bar"
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nikushi/problem_details.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
