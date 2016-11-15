# Visa

Multi-token authentication for Rails apps. Built with Devise in mind, but can be used separately.

## Installation

Something like the following should go in your Gemfile:

```ruby
gem 'visa', '~> 0.0.3'
```

## Usage

Visa doesn't try to do too much. You're expected to provide your own controllers or other Rack API endpoints that handle new sessions, and then check that session is active in the rest of your endpoints/controllers.

The authenticated token details are per-session, and stored separately to Devise and other models.

### Setup

First, you'll want to import Visa's migrations for the `Visa::Token` model:

```
rake visa:install:migrations
```

Visa, like Devise, can be configured to have varying encryption costs. The default is 10, but you'll probably want it to be just 1 for your test environment. Thus, the following should go in an initialiser:

```ruby
Visa.encryption_cost = Rails.env.test? ? 1 : 10
```

### Signing In

Your own code will manage taking email and password parameters and confirming that they're valid.

If they _are_ valid, then you want to create a new `Visa::Token`, and return the access token via JSON or a HTTP header or whatever you like:

```ruby
visa_token   = Visa::Token.create :tokenable => authenticated_user
access_token = "#{visa_token.client_id}#{visa_token.secret}"
```

If they're not, best to return a 403 and a corresponding error message.

### Authenticating

Each authenticated request should use the generated access token, sent through either using a request parameter `access_token`, or a HTTP header `HTTP_AUTHENTICATION`. You can customise the name of the latter in your initialiser via `Visa.request_header`.

Then, in the endpoints/controllers where you're confirming if requests are authenticated:

```ruby
# Pass in the Rack environment. In Rails, this is request.env:
visa_request = Visa::Request.new request.env

# Confirm the request is valid (the equivalent of Devise's user_signed_in?):
visa_request.valid?

# Access the authenticated user (the equivalent of Devise's current_user):
visa_request.tokenable
```

### Signing Out

To mark credentials as no longer valid, you can call `invalidate` on the `Visa::Request` instance:

```ruby
visa_request.invalidate
```

## Wishlist

It'd be nice to have the token be different on each request, though there are issues here with keeping old token values valid for a small window of time to allow for request lag.

And of course, you should be using HTTPS across all requests to ensure the tokens and other data passed around are as secure as possible.

## Contributing

1. Fork it ( https://github.com/inspire9/visa/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

Inspiration has come from [Lynn Dylan Hurley](https://github.com/lynndylanhurley)'s [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth) and [this post](http://www.brianauton.com/posts/token-authentication-devise.html) by [Brian Auton](https://github.com/brianauton).

## Licence

Copyright (c) 2015, Visa is developed and maintained by Pat Allan and Inspire9, and is released under the open MIT Licence.
