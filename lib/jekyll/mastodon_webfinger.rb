# frozen_string_literal: true

require "json"
require "jekyll"
require_relative "mastodon_webfinger/version"
require_relative "mastodon_webfinger/generator"

Jekyll::Hooks.register :site, :after_init do |site|
  keep_files = site.config["keep_files"] || []
  site.config["keep_files"] = keep_files.push(".well-known/webfinger").uniq
end
