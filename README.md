# Plurky

[![Gem Version](https://badge.fury.io/rb/plurky.png)][gem]
[![Build Status](https://travis-ci.org/Domon/plurky.png)][travis]
[![Dependency Status](https://gemnasium.com/Domon/plurky.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/Domon/plurky.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/Domon/plurky/badge.png)][coveralls]

[gem]: http://badge.fury.io/rb/plurky
[travis]: https://travis-ci.org/Domon/plurky
[gemnasium]: https://gemnasium.com/Domon/plurky
[codeclimate]: https://codeclimate.com/github/Domon/plurky
[coveralls]: https://coveralls.io/r/Domon/plurky

Yet another Plurk API wrapper. Or something to play when the Plurk team is busy optimizing the site.

## Installation

Add this line to your application's `Gemfile`:

    gem 'plurky'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plurky

## Documentation

* This gem: http://rdoc.info/gems/plurky
* Plurk API 2.0: http://www.plurk.com/API

## Usage

```ruby
require 'plurky'

client = Plurky.client
client.get '/APP/Profile/getPublicProfile', :user_id => 34
```

## Configuration

Applications that make requests on behalf of a single Plurk user can pass global configuration options as a block to the `Plurky.configure` method.

```ruby
Plurky.configure do |config|
  config.consumer_key       = YOUR_CONSUMER_KEY
  config.consumer_secret    = YOUR_CONSUMER_SECRET
  config.oauth_token        = YOUR_OAUTH_TOKEN
  config.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
end
```

Alternately, you can set the following environment variables:

```
PLURK_CONSUMER_KEY
PLURK_CONSUMER_SECRET
PLURK_OAUTH_TOKEN
PLURK_OAUTH_TOKEN_SECRET
```

After configuration, requests can be made like so:

```ruby
Plurky.get '/APP/Timeline/getPlurks'
```

## TODO

* Complete the tests.
* Add APIs.
* Add support of obtaining access token.

## Credits

Most of the code are copy-pasted from the [twitter][] gem.

[twitter]: https://github.com/sferik/twitter

## Copyright

Copyright (c) 2012 - 2013 Chun-wei Kuo. See [LICENSE][] for details.

[license]: https://github.com/Domon/plurky/blob/master/LICENSE.md

