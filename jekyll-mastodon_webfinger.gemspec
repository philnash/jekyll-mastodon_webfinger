# frozen_string_literal: true

require_relative "lib/jekyll/mastodon_webfinger/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-mastodon_webfinger"
  spec.version = Jekyll::MastodonWebfinger::VERSION
  spec.authors = ["Phil Nash"]
  spec.email = ["philnash@gmail.com"]

  spec.summary = "Use your Jekyll site and domain to forward to your Mastodon profile"
  spec.description = "Allows you to use your own custom domain to point to your" \
   "Mastodon profile by adding a /.well-known/webfinger file to your site output"
  spec.homepage = "https://github.com/philnash/jekyll-mastodon_webfinger"
  spec.required_ruby_version = ">= 2.7.0"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 3.0", "< 5.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
  spec.add_development_dependency "rubocop-rake", "~> 0.6"
  spec.add_development_dependency "rubocop-rspec", "~> 2.15"
  spec.add_development_dependency "simplecov", "~> 0.21"
end
