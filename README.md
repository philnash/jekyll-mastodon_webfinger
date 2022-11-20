# `Jekyll::MastodonWebfinger`

<h2>Use your Jekyll website domain as an alias for your Mastodon username</h2>

This is a [Jekyll](https://jekyllrb.com/) plugin that adds a [WebFinger](https://webfinger.net/) file to your site, allowing you to use your own domain as an alias to help others discover your [Mastodon](https://joinmastodon.org/) profile.

<h3>Try it out</h3>

Search Mastodon for `@phil@philna.sh` and you will find my Mastodon profile.

* [What?](#what)
  * [Alternatives](#alternatives)
* [How to use](#how-to-use)
  * [Config](#config)
  * [Drawbacks](#drawbacks)
* [Development](#development)
* [Contributing](#contributing)
* [Code of Conduct](#code-of-conduct)
* [License](#license)

## What?

You may be tempted to run your own Mastodon instance so that you can use your own domain. If you don't want the work of managing a server you can instead use your domain as an alias to point to your Mastodon profile.

This uses [WebFinger](https://webfinger.net/), which is a way to attach information to an email address or other online resource. In this case you can point email addresses on your own domain to your Mastodon profile.

For example, I have a Mastodon profile at [@philnash@mastodon.social](https://mastodon.social/@philnash). If I add this plugin to my Jekyll site at https://philna.sh and set the username to `philnash` and the instance to `mastodon.social`, then you will be able to find my account by searching for `phil@philna.sh` in any Mastodon instance.

For a more in depth explanation, check out [Mastodon on your own domain without hosting a server
by Maarten Balliauw](https://blog.maartenballiauw.be/post/2022/11/05/mastodon-own-donain-without-hosting-server.html).

### Alternatives

* @dkundel's [netlify-plugin-mastodon-alias](https://github.com/dkundel/netlify-plugin-mastodon-alias)

## How to use

Add the gem to your Jekyll site's `Gemfile` by executing:

    $ bundle add jekyll-mastodon_webfinger

Or by opening the `Gemfile`, adding:

    gem "jekyll-mastodon_webfinger"

and then running `bundle install`.

### Config

You need to add two things to your `_config.yml` file.

1. Add your Mastodon account details. For example:

   ```yml
   mastodon:
     username: philnash
     instance: mastodon.social
   ```

2. Add `jekyll/mastodon_webfinger` to the `plugins` list:

   ```yml
     plugins:
       - jekyll/mastodon_webfinger
   ```

Next time you build your Jekyll site, you will find a `/.well-known/` directory in the output with a `webfinger` file that contains the required JSON.

### Drawbacks

Since this generates a static file, this actually acts like a catch-all email address. `@anything@yourdomain.com` will match and point to the Mastodon profile your define.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/philnash/jekyll-mastodon_webfinger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/philnash/jekyll-mastodon_webfinger/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Jekyll::MastodonWebfinger project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/philnash/jekyll-mastodon_webfinger/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/philnash/jekyll-mastodon_webfinger/blob/main/LICENSE).