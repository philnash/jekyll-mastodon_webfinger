# frozen_string_literal: true

module Jekyll
  module MastodonWebfinger
    # A Jekyll Generator that creates a `/.well-known/webfinger` file in the
    # site output that points to your Mastodon identity
    class Generator < Jekyll::Generator
      def generate(site)
        destination = site.config["destination"]
        mastodon = site.config["mastodon"]
        return unless mastodon && mastodon["username"] && mastodon["instance"]

        username = mastodon["username"]
        instance = mastodon["instance"]

        directory = create_directory(destination)
        write_webfinger_file(directory, username, instance)
      end

      private

      def create_directory(destination)
        directory = File.join(destination, ".well-known")
        FileUtils.mkdir_p(directory)
        directory
      end

      def write_webfinger_file(directory, username, instance)
        filename = File.join(directory, "webfinger")
        File.open(filename, "w") do |file|
          file.write webfinger_json(username, instance)
        end
      end

      # rubocop:disable Metrics/MethodLength
      def webfinger_json(username, instance)
        {
          subject: "acct:#{username}@#{instance}",
          aliases: [
            "https://#{instance}/@#{username}",
            "https://#{instance}/users/#{username}"
          ],
          links: [
            {
              rel: "http://webfinger.net/rel/profile-page",
              type: "text/html",
              href: "https://#{instance}/@#{username}"
            },
            {
              rel: "self",
              type: "application/activity+json",
              href: "https://#{instance}/users/#{username}"
            },
            {
              rel: "http://ostatus.org/schema/1.0/subscribe",
              template: "https://#{instance}/authorize_interaction?uri={uri}"
            }
          ]
        }.to_json
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
